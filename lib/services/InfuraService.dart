import 'dart:convert';
import 'package:http/http.dart' as http;


class InfuraService {
  static const String _projectId = '86cea06e780c450c9af7cfc1f8586952';

  static final Uri _rpcUrl = Uri.parse(
    'https://polygon-mainnet.infura.io/v3/$_projectId',
  );

  // Sends JSON-RPC request and returns the JSON response.
  Future<Map<String, dynamic>> _postRpc(Map<String, dynamic> payload) async {
    final response = await http.post(
      _rpcUrl,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'HTTP ${response.statusCode}: ${response.reasonPhrase}',
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    if (json.containsKey('error')) {
      throw Exception('RPC Error: ${json['error']}');
    }
    return json;
  }

  /// Logs a prescription event on-chain by sending a transaction
  /// with embedded data. Returns the transaction hash.
  ///
  /// [from] must be a valid hex address of an unlocked or pre-funded account.
  /// [to] is optional (e.g. a contract address). If null, Infura will broadcast
  /// a transaction with only data payload (no recipient).
  Future<String> logPrescriptionOnChain({
    required String from,
    String? to,
    required int prescriptionId,
    required int patientId,
    required bool includesControlled,
  }) async {
    // Construct a simple payload string
    final payloadString =
        'prescId:$prescriptionId;patId:$patientId;ctl:$includesControlled';
    // Prefix with 0x and percent-encode
    final dataHex = '0x' + Uri.encodeComponent(payloadString);

    final rpcPayload = {
      'jsonrpc': '2.0',
      'method': 'eth_sendTransaction',
      'params': [
        {
          'from': from,
          if (to != null) 'to': to,
          'data': dataHex,
        }
      ],
      'id': 1,
    };

    final result = await _postRpc(rpcPayload);
    return result['result'] as String;
  }

  /// Retrieves the latest block number from Polygon.
  Future<String> getLatestBlockNumber() async {
    final rpcPayload = {
      'jsonrpc': '2.0',
      'method': 'eth_blockNumber',
      'params': [],
      'id': 1,
    };
    final result = await _postRpc(rpcPayload);
    return result['result'] as String;
  }

  /// Fetches all on-chain prescriptions recorded via `logPrescriptionOnChain`.
  ///
  /// [contractAddress] is the address your transactions were sent to (if any).
  /// [fromBlock] and [toBlock] define the block range to scan (in decimal).
  Future<List<Map<String, dynamic>>> fetchAllPrescriptions({
    required String contractAddress,
    int fromBlock = 0,
    String toBlock = 'latest',
  }) async {
    // Build filter for eth_getLogs
    final filter = {
      'address': contractAddress,
      'fromBlock': '0x${fromBlock.toRadixString(16)}',
      'toBlock': toBlock,
    };
    final rpcPayload = {
      'jsonrpc': '2.0',
      'method': 'eth_getLogs',
      'params': [filter],
      'id': 1,
    };

    final json = await _postRpc(rpcPayload);
    final logs = (json['result'] as List<dynamic>);

    // Decode each log's data field into a key-value map
    return logs.map((log) {
      final dataHex = log['data'] as String;
      final raw = dataHex.startsWith('0x') ? dataHex.substring(2) : dataHex;
      final decoded = Uri.decodeComponent(raw);
      final entries = decoded.split(';');
      final map = <String, dynamic>{};
      for (var entry in entries) {
        final parts = entry.split(':');
        if (parts.length == 2) {
          final key = parts[0];
          var value = parts[1];
          if (int.tryParse(value) != null) {
            value = int.parse(value) as String;
          } else if (value == 'true' || value == 'false') {
            value = (value == 'true') as String;
          }
          map[key] = value;
        }
      }
      return map;
    }).toList();
  }
}
