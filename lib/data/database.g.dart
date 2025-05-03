// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _firstNameMeta =
      const VerificationMeta('firstName');
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
      'first_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _lastNameMeta =
      const VerificationMeta('lastName');
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
      'last_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _nationalIdMeta =
      const VerificationMeta('nationalId');
  @override
  late final GeneratedColumn<String> nationalId = GeneratedColumn<String>(
      'national_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _syndicateNumberMeta =
      const VerificationMeta('syndicateNumber');
  @override
  late final GeneratedColumn<String> syndicateNumber = GeneratedColumn<String>(
      'syndicate_number', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _passwordHashMeta =
      const VerificationMeta('passwordHash');
  @override
  late final GeneratedColumn<String> passwordHash = GeneratedColumn<String>(
      'password_hash', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        firstName,
        lastName,
        email,
        phone,
        nationalId,
        syndicateNumber,
        passwordHash,
        role,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('national_id')) {
      context.handle(
          _nationalIdMeta,
          nationalId.isAcceptableOrUnknown(
              data['national_id']!, _nationalIdMeta));
    } else if (isInserting) {
      context.missing(_nationalIdMeta);
    }
    if (data.containsKey('syndicate_number')) {
      context.handle(
          _syndicateNumberMeta,
          syndicateNumber.isAcceptableOrUnknown(
              data['syndicate_number']!, _syndicateNumberMeta));
    }
    if (data.containsKey('password_hash')) {
      context.handle(
          _passwordHashMeta,
          passwordHash.isAcceptableOrUnknown(
              data['password_hash']!, _passwordHashMeta));
    } else if (isInserting) {
      context.missing(_passwordHashMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      firstName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}first_name'])!,
      lastName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_name'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone'])!,
      nationalId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}national_id'])!,
      syndicateNumber: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}syndicate_number']),
      passwordHash: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password_hash'])!,
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String nationalId;
  final String? syndicateNumber;
  final String passwordHash;
  final String role;
  final DateTime createdAt;
  const User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.phone,
      required this.nationalId,
      this.syndicateNumber,
      required this.passwordHash,
      required this.role,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    map['email'] = Variable<String>(email);
    map['phone'] = Variable<String>(phone);
    map['national_id'] = Variable<String>(nationalId);
    if (!nullToAbsent || syndicateNumber != null) {
      map['syndicate_number'] = Variable<String>(syndicateNumber);
    }
    map['password_hash'] = Variable<String>(passwordHash);
    map['role'] = Variable<String>(role);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      firstName: Value(firstName),
      lastName: Value(lastName),
      email: Value(email),
      phone: Value(phone),
      nationalId: Value(nationalId),
      syndicateNumber: syndicateNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(syndicateNumber),
      passwordHash: Value(passwordHash),
      role: Value(role),
      createdAt: Value(createdAt),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      email: serializer.fromJson<String>(json['email']),
      phone: serializer.fromJson<String>(json['phone']),
      nationalId: serializer.fromJson<String>(json['nationalId']),
      syndicateNumber: serializer.fromJson<String?>(json['syndicateNumber']),
      passwordHash: serializer.fromJson<String>(json['passwordHash']),
      role: serializer.fromJson<String>(json['role']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'email': serializer.toJson<String>(email),
      'phone': serializer.toJson<String>(phone),
      'nationalId': serializer.toJson<String>(nationalId),
      'syndicateNumber': serializer.toJson<String?>(syndicateNumber),
      'passwordHash': serializer.toJson<String>(passwordHash),
      'role': serializer.toJson<String>(role),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  User copyWith(
          {int? id,
          String? firstName,
          String? lastName,
          String? email,
          String? phone,
          String? nationalId,
          Value<String?> syndicateNumber = const Value.absent(),
          String? passwordHash,
          String? role,
          DateTime? createdAt}) =>
      User(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        nationalId: nationalId ?? this.nationalId,
        syndicateNumber: syndicateNumber.present
            ? syndicateNumber.value
            : this.syndicateNumber,
        passwordHash: passwordHash ?? this.passwordHash,
        role: role ?? this.role,
        createdAt: createdAt ?? this.createdAt,
      );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      nationalId:
          data.nationalId.present ? data.nationalId.value : this.nationalId,
      syndicateNumber: data.syndicateNumber.present
          ? data.syndicateNumber.value
          : this.syndicateNumber,
      passwordHash: data.passwordHash.present
          ? data.passwordHash.value
          : this.passwordHash,
      role: data.role.present ? data.role.value : this.role,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('nationalId: $nationalId, ')
          ..write('syndicateNumber: $syndicateNumber, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('role: $role, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, firstName, lastName, email, phone,
      nationalId, syndicateNumber, passwordHash, role, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.nationalId == this.nationalId &&
          other.syndicateNumber == this.syndicateNumber &&
          other.passwordHash == this.passwordHash &&
          other.role == this.role &&
          other.createdAt == this.createdAt);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<String> email;
  final Value<String> phone;
  final Value<String> nationalId;
  final Value<String?> syndicateNumber;
  final Value<String> passwordHash;
  final Value<String> role;
  final Value<DateTime> createdAt;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.nationalId = const Value.absent(),
    this.syndicateNumber = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.role = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String nationalId,
    this.syndicateNumber = const Value.absent(),
    required String passwordHash,
    required String role,
    this.createdAt = const Value.absent(),
  })  : firstName = Value(firstName),
        lastName = Value(lastName),
        email = Value(email),
        phone = Value(phone),
        nationalId = Value(nationalId),
        passwordHash = Value(passwordHash),
        role = Value(role);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? nationalId,
    Expression<String>? syndicateNumber,
    Expression<String>? passwordHash,
    Expression<String>? role,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (nationalId != null) 'national_id': nationalId,
      if (syndicateNumber != null) 'syndicate_number': syndicateNumber,
      if (passwordHash != null) 'password_hash': passwordHash,
      if (role != null) 'role': role,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? id,
      Value<String>? firstName,
      Value<String>? lastName,
      Value<String>? email,
      Value<String>? phone,
      Value<String>? nationalId,
      Value<String?>? syndicateNumber,
      Value<String>? passwordHash,
      Value<String>? role,
      Value<DateTime>? createdAt}) {
    return UsersCompanion(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      nationalId: nationalId ?? this.nationalId,
      syndicateNumber: syndicateNumber ?? this.syndicateNumber,
      passwordHash: passwordHash ?? this.passwordHash,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (nationalId.present) {
      map['national_id'] = Variable<String>(nationalId.value);
    }
    if (syndicateNumber.present) {
      map['syndicate_number'] = Variable<String>(syndicateNumber.value);
    }
    if (passwordHash.present) {
      map['password_hash'] = Variable<String>(passwordHash.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('nationalId: $nationalId, ')
          ..write('syndicateNumber: $syndicateNumber, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('role: $role, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PharmaciesTable extends Pharmacies
    with TableInfo<$PharmaciesTable, Pharmacy> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PharmaciesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _pharmacyIdMeta =
      const VerificationMeta('pharmacyId');
  @override
  late final GeneratedColumn<int> pharmacyId = GeneratedColumn<int>(
      'pharmacy_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _latitudeMeta =
      const VerificationMeta('latitude');
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
      'latitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _longitudeMeta =
      const VerificationMeta('longitude');
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
      'longitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _acceptsInsuranceMeta =
      const VerificationMeta('acceptsInsurance');
  @override
  late final GeneratedColumn<bool> acceptsInsurance = GeneratedColumn<bool>(
      'accepts_insurance', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("accepts_insurance" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [pharmacyId, name, address, phone, latitude, longitude, acceptsInsurance];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pharmacies';
  @override
  VerificationContext validateIntegrity(Insertable<Pharmacy> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pharmacy_id')) {
      context.handle(
          _pharmacyIdMeta,
          pharmacyId.isAcceptableOrUnknown(
              data['pharmacy_id']!, _pharmacyIdMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    }
    if (data.containsKey('accepts_insurance')) {
      context.handle(
          _acceptsInsuranceMeta,
          acceptsInsurance.isAcceptableOrUnknown(
              data['accepts_insurance']!, _acceptsInsuranceMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {pharmacyId};
  @override
  Pharmacy map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Pharmacy(
      pharmacyId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}pharmacy_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address']),
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      latitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}latitude']),
      longitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}longitude']),
      acceptsInsurance: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}accepts_insurance'])!,
    );
  }

  @override
  $PharmaciesTable createAlias(String alias) {
    return $PharmaciesTable(attachedDatabase, alias);
  }
}

class Pharmacy extends DataClass implements Insertable<Pharmacy> {
  final int pharmacyId;
  final String name;
  final String? address;
  final String? phone;
  final double? latitude;
  final double? longitude;
  final bool acceptsInsurance;
  const Pharmacy(
      {required this.pharmacyId,
      required this.name,
      this.address,
      this.phone,
      this.latitude,
      this.longitude,
      required this.acceptsInsurance});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pharmacy_id'] = Variable<int>(pharmacyId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    map['accepts_insurance'] = Variable<bool>(acceptsInsurance);
    return map;
  }

  PharmaciesCompanion toCompanion(bool nullToAbsent) {
    return PharmaciesCompanion(
      pharmacyId: Value(pharmacyId),
      name: Value(name),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      acceptsInsurance: Value(acceptsInsurance),
    );
  }

  factory Pharmacy.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Pharmacy(
      pharmacyId: serializer.fromJson<int>(json['pharmacyId']),
      name: serializer.fromJson<String>(json['name']),
      address: serializer.fromJson<String?>(json['address']),
      phone: serializer.fromJson<String?>(json['phone']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      acceptsInsurance: serializer.fromJson<bool>(json['acceptsInsurance']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'pharmacyId': serializer.toJson<int>(pharmacyId),
      'name': serializer.toJson<String>(name),
      'address': serializer.toJson<String?>(address),
      'phone': serializer.toJson<String?>(phone),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'acceptsInsurance': serializer.toJson<bool>(acceptsInsurance),
    };
  }

  Pharmacy copyWith(
          {int? pharmacyId,
          String? name,
          Value<String?> address = const Value.absent(),
          Value<String?> phone = const Value.absent(),
          Value<double?> latitude = const Value.absent(),
          Value<double?> longitude = const Value.absent(),
          bool? acceptsInsurance}) =>
      Pharmacy(
        pharmacyId: pharmacyId ?? this.pharmacyId,
        name: name ?? this.name,
        address: address.present ? address.value : this.address,
        phone: phone.present ? phone.value : this.phone,
        latitude: latitude.present ? latitude.value : this.latitude,
        longitude: longitude.present ? longitude.value : this.longitude,
        acceptsInsurance: acceptsInsurance ?? this.acceptsInsurance,
      );
  Pharmacy copyWithCompanion(PharmaciesCompanion data) {
    return Pharmacy(
      pharmacyId:
          data.pharmacyId.present ? data.pharmacyId.value : this.pharmacyId,
      name: data.name.present ? data.name.value : this.name,
      address: data.address.present ? data.address.value : this.address,
      phone: data.phone.present ? data.phone.value : this.phone,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      acceptsInsurance: data.acceptsInsurance.present
          ? data.acceptsInsurance.value
          : this.acceptsInsurance,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Pharmacy(')
          ..write('pharmacyId: $pharmacyId, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('phone: $phone, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('acceptsInsurance: $acceptsInsurance')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      pharmacyId, name, address, phone, latitude, longitude, acceptsInsurance);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Pharmacy &&
          other.pharmacyId == this.pharmacyId &&
          other.name == this.name &&
          other.address == this.address &&
          other.phone == this.phone &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.acceptsInsurance == this.acceptsInsurance);
}

class PharmaciesCompanion extends UpdateCompanion<Pharmacy> {
  final Value<int> pharmacyId;
  final Value<String> name;
  final Value<String?> address;
  final Value<String?> phone;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<bool> acceptsInsurance;
  const PharmaciesCompanion({
    this.pharmacyId = const Value.absent(),
    this.name = const Value.absent(),
    this.address = const Value.absent(),
    this.phone = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.acceptsInsurance = const Value.absent(),
  });
  PharmaciesCompanion.insert({
    this.pharmacyId = const Value.absent(),
    required String name,
    this.address = const Value.absent(),
    this.phone = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.acceptsInsurance = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Pharmacy> custom({
    Expression<int>? pharmacyId,
    Expression<String>? name,
    Expression<String>? address,
    Expression<String>? phone,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<bool>? acceptsInsurance,
  }) {
    return RawValuesInsertable({
      if (pharmacyId != null) 'pharmacy_id': pharmacyId,
      if (name != null) 'name': name,
      if (address != null) 'address': address,
      if (phone != null) 'phone': phone,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (acceptsInsurance != null) 'accepts_insurance': acceptsInsurance,
    });
  }

  PharmaciesCompanion copyWith(
      {Value<int>? pharmacyId,
      Value<String>? name,
      Value<String?>? address,
      Value<String?>? phone,
      Value<double?>? latitude,
      Value<double?>? longitude,
      Value<bool>? acceptsInsurance}) {
    return PharmaciesCompanion(
      pharmacyId: pharmacyId ?? this.pharmacyId,
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      acceptsInsurance: acceptsInsurance ?? this.acceptsInsurance,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pharmacyId.present) {
      map['pharmacy_id'] = Variable<int>(pharmacyId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (acceptsInsurance.present) {
      map['accepts_insurance'] = Variable<bool>(acceptsInsurance.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PharmaciesCompanion(')
          ..write('pharmacyId: $pharmacyId, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('phone: $phone, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('acceptsInsurance: $acceptsInsurance')
          ..write(')'))
        .toString();
  }
}

class $MedicationsTable extends Medications
    with TableInfo<$MedicationsTable, Medication> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MedicationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _medicationIdMeta =
      const VerificationMeta('medicationId');
  @override
  late final GeneratedColumn<int> medicationId = GeneratedColumn<int>(
      'medication_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _controlledSubstanceMeta =
      const VerificationMeta('controlledSubstance');
  @override
  late final GeneratedColumn<bool> controlledSubstance = GeneratedColumn<bool>(
      'controlled_substance', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("controlled_substance" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [medicationId, name, description, controlledSubstance];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'medications';
  @override
  VerificationContext validateIntegrity(Insertable<Medication> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('medication_id')) {
      context.handle(
          _medicationIdMeta,
          medicationId.isAcceptableOrUnknown(
              data['medication_id']!, _medicationIdMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('controlled_substance')) {
      context.handle(
          _controlledSubstanceMeta,
          controlledSubstance.isAcceptableOrUnknown(
              data['controlled_substance']!, _controlledSubstanceMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {medicationId};
  @override
  Medication map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Medication(
      medicationId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}medication_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      controlledSubstance: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}controlled_substance'])!,
    );
  }

  @override
  $MedicationsTable createAlias(String alias) {
    return $MedicationsTable(attachedDatabase, alias);
  }
}

class Medication extends DataClass implements Insertable<Medication> {
  final int medicationId;
  final String name;
  final String? description;
  final bool controlledSubstance;
  const Medication(
      {required this.medicationId,
      required this.name,
      this.description,
      required this.controlledSubstance});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['medication_id'] = Variable<int>(medicationId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['controlled_substance'] = Variable<bool>(controlledSubstance);
    return map;
  }

  MedicationsCompanion toCompanion(bool nullToAbsent) {
    return MedicationsCompanion(
      medicationId: Value(medicationId),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      controlledSubstance: Value(controlledSubstance),
    );
  }

  factory Medication.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Medication(
      medicationId: serializer.fromJson<int>(json['medicationId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      controlledSubstance:
          serializer.fromJson<bool>(json['controlledSubstance']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'medicationId': serializer.toJson<int>(medicationId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'controlledSubstance': serializer.toJson<bool>(controlledSubstance),
    };
  }

  Medication copyWith(
          {int? medicationId,
          String? name,
          Value<String?> description = const Value.absent(),
          bool? controlledSubstance}) =>
      Medication(
        medicationId: medicationId ?? this.medicationId,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        controlledSubstance: controlledSubstance ?? this.controlledSubstance,
      );
  Medication copyWithCompanion(MedicationsCompanion data) {
    return Medication(
      medicationId: data.medicationId.present
          ? data.medicationId.value
          : this.medicationId,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      controlledSubstance: data.controlledSubstance.present
          ? data.controlledSubstance.value
          : this.controlledSubstance,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Medication(')
          ..write('medicationId: $medicationId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('controlledSubstance: $controlledSubstance')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(medicationId, name, description, controlledSubstance);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Medication &&
          other.medicationId == this.medicationId &&
          other.name == this.name &&
          other.description == this.description &&
          other.controlledSubstance == this.controlledSubstance);
}

class MedicationsCompanion extends UpdateCompanion<Medication> {
  final Value<int> medicationId;
  final Value<String> name;
  final Value<String?> description;
  final Value<bool> controlledSubstance;
  const MedicationsCompanion({
    this.medicationId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.controlledSubstance = const Value.absent(),
  });
  MedicationsCompanion.insert({
    this.medicationId = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.controlledSubstance = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Medication> custom({
    Expression<int>? medicationId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<bool>? controlledSubstance,
  }) {
    return RawValuesInsertable({
      if (medicationId != null) 'medication_id': medicationId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (controlledSubstance != null)
        'controlled_substance': controlledSubstance,
    });
  }

  MedicationsCompanion copyWith(
      {Value<int>? medicationId,
      Value<String>? name,
      Value<String?>? description,
      Value<bool>? controlledSubstance}) {
    return MedicationsCompanion(
      medicationId: medicationId ?? this.medicationId,
      name: name ?? this.name,
      description: description ?? this.description,
      controlledSubstance: controlledSubstance ?? this.controlledSubstance,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (medicationId.present) {
      map['medication_id'] = Variable<int>(medicationId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (controlledSubstance.present) {
      map['controlled_substance'] = Variable<bool>(controlledSubstance.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MedicationsCompanion(')
          ..write('medicationId: $medicationId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('controlledSubstance: $controlledSubstance')
          ..write(')'))
        .toString();
  }
}

class $InventoryTable extends Inventory
    with TableInfo<$InventoryTable, InventoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _inventoryIdMeta =
      const VerificationMeta('inventoryId');
  @override
  late final GeneratedColumn<int> inventoryId = GeneratedColumn<int>(
      'inventory_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _pharmacyIdMeta =
      const VerificationMeta('pharmacyId');
  @override
  late final GeneratedColumn<int> pharmacyId = GeneratedColumn<int>(
      'pharmacy_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _medicationIdMeta =
      const VerificationMeta('medicationId');
  @override
  late final GeneratedColumn<int> medicationId = GeneratedColumn<int>(
      'medication_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _reorderThresholdMeta =
      const VerificationMeta('reorderThreshold');
  @override
  late final GeneratedColumn<int> reorderThreshold = GeneratedColumn<int>(
      'reorder_threshold', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
      'price', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  @override
  List<GeneratedColumn> get $columns => [
        inventoryId,
        pharmacyId,
        medicationId,
        quantity,
        reorderThreshold,
        price
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inventory';
  @override
  VerificationContext validateIntegrity(Insertable<InventoryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('inventory_id')) {
      context.handle(
          _inventoryIdMeta,
          inventoryId.isAcceptableOrUnknown(
              data['inventory_id']!, _inventoryIdMeta));
    }
    if (data.containsKey('pharmacy_id')) {
      context.handle(
          _pharmacyIdMeta,
          pharmacyId.isAcceptableOrUnknown(
              data['pharmacy_id']!, _pharmacyIdMeta));
    } else if (isInserting) {
      context.missing(_pharmacyIdMeta);
    }
    if (data.containsKey('medication_id')) {
      context.handle(
          _medicationIdMeta,
          medicationId.isAcceptableOrUnknown(
              data['medication_id']!, _medicationIdMeta));
    } else if (isInserting) {
      context.missing(_medicationIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    }
    if (data.containsKey('reorder_threshold')) {
      context.handle(
          _reorderThresholdMeta,
          reorderThreshold.isAcceptableOrUnknown(
              data['reorder_threshold']!, _reorderThresholdMeta));
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {inventoryId};
  @override
  InventoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InventoryData(
      inventoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}inventory_id'])!,
      pharmacyId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}pharmacy_id'])!,
      medicationId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}medication_id'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
      reorderThreshold: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reorder_threshold'])!,
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}price'])!,
    );
  }

  @override
  $InventoryTable createAlias(String alias) {
    return $InventoryTable(attachedDatabase, alias);
  }
}

class InventoryData extends DataClass implements Insertable<InventoryData> {
  final int inventoryId;
  final int pharmacyId;
  final int medicationId;
  final int quantity;
  final int reorderThreshold;
  final double price;
  const InventoryData(
      {required this.inventoryId,
      required this.pharmacyId,
      required this.medicationId,
      required this.quantity,
      required this.reorderThreshold,
      required this.price});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['inventory_id'] = Variable<int>(inventoryId);
    map['pharmacy_id'] = Variable<int>(pharmacyId);
    map['medication_id'] = Variable<int>(medicationId);
    map['quantity'] = Variable<int>(quantity);
    map['reorder_threshold'] = Variable<int>(reorderThreshold);
    map['price'] = Variable<double>(price);
    return map;
  }

  InventoryCompanion toCompanion(bool nullToAbsent) {
    return InventoryCompanion(
      inventoryId: Value(inventoryId),
      pharmacyId: Value(pharmacyId),
      medicationId: Value(medicationId),
      quantity: Value(quantity),
      reorderThreshold: Value(reorderThreshold),
      price: Value(price),
    );
  }

  factory InventoryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InventoryData(
      inventoryId: serializer.fromJson<int>(json['inventoryId']),
      pharmacyId: serializer.fromJson<int>(json['pharmacyId']),
      medicationId: serializer.fromJson<int>(json['medicationId']),
      quantity: serializer.fromJson<int>(json['quantity']),
      reorderThreshold: serializer.fromJson<int>(json['reorderThreshold']),
      price: serializer.fromJson<double>(json['price']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'inventoryId': serializer.toJson<int>(inventoryId),
      'pharmacyId': serializer.toJson<int>(pharmacyId),
      'medicationId': serializer.toJson<int>(medicationId),
      'quantity': serializer.toJson<int>(quantity),
      'reorderThreshold': serializer.toJson<int>(reorderThreshold),
      'price': serializer.toJson<double>(price),
    };
  }

  InventoryData copyWith(
          {int? inventoryId,
          int? pharmacyId,
          int? medicationId,
          int? quantity,
          int? reorderThreshold,
          double? price}) =>
      InventoryData(
        inventoryId: inventoryId ?? this.inventoryId,
        pharmacyId: pharmacyId ?? this.pharmacyId,
        medicationId: medicationId ?? this.medicationId,
        quantity: quantity ?? this.quantity,
        reorderThreshold: reorderThreshold ?? this.reorderThreshold,
        price: price ?? this.price,
      );
  InventoryData copyWithCompanion(InventoryCompanion data) {
    return InventoryData(
      inventoryId:
          data.inventoryId.present ? data.inventoryId.value : this.inventoryId,
      pharmacyId:
          data.pharmacyId.present ? data.pharmacyId.value : this.pharmacyId,
      medicationId: data.medicationId.present
          ? data.medicationId.value
          : this.medicationId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      reorderThreshold: data.reorderThreshold.present
          ? data.reorderThreshold.value
          : this.reorderThreshold,
      price: data.price.present ? data.price.value : this.price,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InventoryData(')
          ..write('inventoryId: $inventoryId, ')
          ..write('pharmacyId: $pharmacyId, ')
          ..write('medicationId: $medicationId, ')
          ..write('quantity: $quantity, ')
          ..write('reorderThreshold: $reorderThreshold, ')
          ..write('price: $price')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      inventoryId, pharmacyId, medicationId, quantity, reorderThreshold, price);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InventoryData &&
          other.inventoryId == this.inventoryId &&
          other.pharmacyId == this.pharmacyId &&
          other.medicationId == this.medicationId &&
          other.quantity == this.quantity &&
          other.reorderThreshold == this.reorderThreshold &&
          other.price == this.price);
}

class InventoryCompanion extends UpdateCompanion<InventoryData> {
  final Value<int> inventoryId;
  final Value<int> pharmacyId;
  final Value<int> medicationId;
  final Value<int> quantity;
  final Value<int> reorderThreshold;
  final Value<double> price;
  const InventoryCompanion({
    this.inventoryId = const Value.absent(),
    this.pharmacyId = const Value.absent(),
    this.medicationId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.reorderThreshold = const Value.absent(),
    this.price = const Value.absent(),
  });
  InventoryCompanion.insert({
    this.inventoryId = const Value.absent(),
    required int pharmacyId,
    required int medicationId,
    this.quantity = const Value.absent(),
    this.reorderThreshold = const Value.absent(),
    this.price = const Value.absent(),
  })  : pharmacyId = Value(pharmacyId),
        medicationId = Value(medicationId);
  static Insertable<InventoryData> custom({
    Expression<int>? inventoryId,
    Expression<int>? pharmacyId,
    Expression<int>? medicationId,
    Expression<int>? quantity,
    Expression<int>? reorderThreshold,
    Expression<double>? price,
  }) {
    return RawValuesInsertable({
      if (inventoryId != null) 'inventory_id': inventoryId,
      if (pharmacyId != null) 'pharmacy_id': pharmacyId,
      if (medicationId != null) 'medication_id': medicationId,
      if (quantity != null) 'quantity': quantity,
      if (reorderThreshold != null) 'reorder_threshold': reorderThreshold,
      if (price != null) 'price': price,
    });
  }

  InventoryCompanion copyWith(
      {Value<int>? inventoryId,
      Value<int>? pharmacyId,
      Value<int>? medicationId,
      Value<int>? quantity,
      Value<int>? reorderThreshold,
      Value<double>? price}) {
    return InventoryCompanion(
      inventoryId: inventoryId ?? this.inventoryId,
      pharmacyId: pharmacyId ?? this.pharmacyId,
      medicationId: medicationId ?? this.medicationId,
      quantity: quantity ?? this.quantity,
      reorderThreshold: reorderThreshold ?? this.reorderThreshold,
      price: price ?? this.price,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (inventoryId.present) {
      map['inventory_id'] = Variable<int>(inventoryId.value);
    }
    if (pharmacyId.present) {
      map['pharmacy_id'] = Variable<int>(pharmacyId.value);
    }
    if (medicationId.present) {
      map['medication_id'] = Variable<int>(medicationId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (reorderThreshold.present) {
      map['reorder_threshold'] = Variable<int>(reorderThreshold.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InventoryCompanion(')
          ..write('inventoryId: $inventoryId, ')
          ..write('pharmacyId: $pharmacyId, ')
          ..write('medicationId: $medicationId, ')
          ..write('quantity: $quantity, ')
          ..write('reorderThreshold: $reorderThreshold, ')
          ..write('price: $price')
          ..write(')'))
        .toString();
  }
}

class $PrescriptionsTable extends Prescriptions
    with TableInfo<$PrescriptionsTable, Prescription> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PrescriptionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _prescriptionIdMeta =
      const VerificationMeta('prescriptionId');
  @override
  late final GeneratedColumn<int> prescriptionId = GeneratedColumn<int>(
      'prescription_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _patientIdMeta =
      const VerificationMeta('patientId');
  @override
  late final GeneratedColumn<int> patientId = GeneratedColumn<int>(
      'patient_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _physicianIdMeta =
      const VerificationMeta('physicianId');
  @override
  late final GeneratedColumn<int> physicianId = GeneratedColumn<int>(
      'physician_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _instructionsMeta =
      const VerificationMeta('instructions');
  @override
  late final GeneratedColumn<String> instructions = GeneratedColumn<String>(
      'instructions', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [prescriptionId, patientId, physicianId, createdAt, status, instructions];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'prescriptions';
  @override
  VerificationContext validateIntegrity(Insertable<Prescription> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('prescription_id')) {
      context.handle(
          _prescriptionIdMeta,
          prescriptionId.isAcceptableOrUnknown(
              data['prescription_id']!, _prescriptionIdMeta));
    }
    if (data.containsKey('patient_id')) {
      context.handle(_patientIdMeta,
          patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta));
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('physician_id')) {
      context.handle(
          _physicianIdMeta,
          physicianId.isAcceptableOrUnknown(
              data['physician_id']!, _physicianIdMeta));
    } else if (isInserting) {
      context.missing(_physicianIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('instructions')) {
      context.handle(
          _instructionsMeta,
          instructions.isAcceptableOrUnknown(
              data['instructions']!, _instructionsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {prescriptionId};
  @override
  Prescription map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Prescription(
      prescriptionId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}prescription_id'])!,
      patientId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}patient_id'])!,
      physicianId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}physician_id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      instructions: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}instructions']),
    );
  }

  @override
  $PrescriptionsTable createAlias(String alias) {
    return $PrescriptionsTable(attachedDatabase, alias);
  }
}

class Prescription extends DataClass implements Insertable<Prescription> {
  final int prescriptionId;
  final int patientId;
  final int physicianId;
  final DateTime createdAt;
  final String status;
  final String? instructions;
  const Prescription(
      {required this.prescriptionId,
      required this.patientId,
      required this.physicianId,
      required this.createdAt,
      required this.status,
      this.instructions});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['prescription_id'] = Variable<int>(prescriptionId);
    map['patient_id'] = Variable<int>(patientId);
    map['physician_id'] = Variable<int>(physicianId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || instructions != null) {
      map['instructions'] = Variable<String>(instructions);
    }
    return map;
  }

  PrescriptionsCompanion toCompanion(bool nullToAbsent) {
    return PrescriptionsCompanion(
      prescriptionId: Value(prescriptionId),
      patientId: Value(patientId),
      physicianId: Value(physicianId),
      createdAt: Value(createdAt),
      status: Value(status),
      instructions: instructions == null && nullToAbsent
          ? const Value.absent()
          : Value(instructions),
    );
  }

  factory Prescription.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Prescription(
      prescriptionId: serializer.fromJson<int>(json['prescriptionId']),
      patientId: serializer.fromJson<int>(json['patientId']),
      physicianId: serializer.fromJson<int>(json['physicianId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      status: serializer.fromJson<String>(json['status']),
      instructions: serializer.fromJson<String?>(json['instructions']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'prescriptionId': serializer.toJson<int>(prescriptionId),
      'patientId': serializer.toJson<int>(patientId),
      'physicianId': serializer.toJson<int>(physicianId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'status': serializer.toJson<String>(status),
      'instructions': serializer.toJson<String?>(instructions),
    };
  }

  Prescription copyWith(
          {int? prescriptionId,
          int? patientId,
          int? physicianId,
          DateTime? createdAt,
          String? status,
          Value<String?> instructions = const Value.absent()}) =>
      Prescription(
        prescriptionId: prescriptionId ?? this.prescriptionId,
        patientId: patientId ?? this.patientId,
        physicianId: physicianId ?? this.physicianId,
        createdAt: createdAt ?? this.createdAt,
        status: status ?? this.status,
        instructions:
            instructions.present ? instructions.value : this.instructions,
      );
  Prescription copyWithCompanion(PrescriptionsCompanion data) {
    return Prescription(
      prescriptionId: data.prescriptionId.present
          ? data.prescriptionId.value
          : this.prescriptionId,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      physicianId:
          data.physicianId.present ? data.physicianId.value : this.physicianId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      status: data.status.present ? data.status.value : this.status,
      instructions: data.instructions.present
          ? data.instructions.value
          : this.instructions,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Prescription(')
          ..write('prescriptionId: $prescriptionId, ')
          ..write('patientId: $patientId, ')
          ..write('physicianId: $physicianId, ')
          ..write('createdAt: $createdAt, ')
          ..write('status: $status, ')
          ..write('instructions: $instructions')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      prescriptionId, patientId, physicianId, createdAt, status, instructions);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Prescription &&
          other.prescriptionId == this.prescriptionId &&
          other.patientId == this.patientId &&
          other.physicianId == this.physicianId &&
          other.createdAt == this.createdAt &&
          other.status == this.status &&
          other.instructions == this.instructions);
}

class PrescriptionsCompanion extends UpdateCompanion<Prescription> {
  final Value<int> prescriptionId;
  final Value<int> patientId;
  final Value<int> physicianId;
  final Value<DateTime> createdAt;
  final Value<String> status;
  final Value<String?> instructions;
  const PrescriptionsCompanion({
    this.prescriptionId = const Value.absent(),
    this.patientId = const Value.absent(),
    this.physicianId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.status = const Value.absent(),
    this.instructions = const Value.absent(),
  });
  PrescriptionsCompanion.insert({
    this.prescriptionId = const Value.absent(),
    required int patientId,
    required int physicianId,
    this.createdAt = const Value.absent(),
    this.status = const Value.absent(),
    this.instructions = const Value.absent(),
  })  : patientId = Value(patientId),
        physicianId = Value(physicianId);
  static Insertable<Prescription> custom({
    Expression<int>? prescriptionId,
    Expression<int>? patientId,
    Expression<int>? physicianId,
    Expression<DateTime>? createdAt,
    Expression<String>? status,
    Expression<String>? instructions,
  }) {
    return RawValuesInsertable({
      if (prescriptionId != null) 'prescription_id': prescriptionId,
      if (patientId != null) 'patient_id': patientId,
      if (physicianId != null) 'physician_id': physicianId,
      if (createdAt != null) 'created_at': createdAt,
      if (status != null) 'status': status,
      if (instructions != null) 'instructions': instructions,
    });
  }

  PrescriptionsCompanion copyWith(
      {Value<int>? prescriptionId,
      Value<int>? patientId,
      Value<int>? physicianId,
      Value<DateTime>? createdAt,
      Value<String>? status,
      Value<String?>? instructions}) {
    return PrescriptionsCompanion(
      prescriptionId: prescriptionId ?? this.prescriptionId,
      patientId: patientId ?? this.patientId,
      physicianId: physicianId ?? this.physicianId,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      instructions: instructions ?? this.instructions,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (prescriptionId.present) {
      map['prescription_id'] = Variable<int>(prescriptionId.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<int>(patientId.value);
    }
    if (physicianId.present) {
      map['physician_id'] = Variable<int>(physicianId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (instructions.present) {
      map['instructions'] = Variable<String>(instructions.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PrescriptionsCompanion(')
          ..write('prescriptionId: $prescriptionId, ')
          ..write('patientId: $patientId, ')
          ..write('physicianId: $physicianId, ')
          ..write('createdAt: $createdAt, ')
          ..write('status: $status, ')
          ..write('instructions: $instructions')
          ..write(')'))
        .toString();
  }
}

class $PrescriptionItemsTable extends PrescriptionItems
    with TableInfo<$PrescriptionItemsTable, PrescriptionItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PrescriptionItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<int> itemId = GeneratedColumn<int>(
      'item_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _prescriptionIdMeta =
      const VerificationMeta('prescriptionId');
  @override
  late final GeneratedColumn<int> prescriptionId = GeneratedColumn<int>(
      'prescription_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _medicationIdMeta =
      const VerificationMeta('medicationId');
  @override
  late final GeneratedColumn<int> medicationId = GeneratedColumn<int>(
      'medication_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _dosageMeta = const VerificationMeta('dosage');
  @override
  late final GeneratedColumn<String> dosage = GeneratedColumn<String>(
      'dosage', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _frequencyMeta =
      const VerificationMeta('frequency');
  @override
  late final GeneratedColumn<String> frequency = GeneratedColumn<String>(
      'frequency', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  @override
  List<GeneratedColumn> get $columns =>
      [itemId, prescriptionId, medicationId, dosage, frequency, quantity];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'prescription_items';
  @override
  VerificationContext validateIntegrity(Insertable<PrescriptionItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('item_id')) {
      context.handle(_itemIdMeta,
          itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta));
    }
    if (data.containsKey('prescription_id')) {
      context.handle(
          _prescriptionIdMeta,
          prescriptionId.isAcceptableOrUnknown(
              data['prescription_id']!, _prescriptionIdMeta));
    } else if (isInserting) {
      context.missing(_prescriptionIdMeta);
    }
    if (data.containsKey('medication_id')) {
      context.handle(
          _medicationIdMeta,
          medicationId.isAcceptableOrUnknown(
              data['medication_id']!, _medicationIdMeta));
    } else if (isInserting) {
      context.missing(_medicationIdMeta);
    }
    if (data.containsKey('dosage')) {
      context.handle(_dosageMeta,
          dosage.isAcceptableOrUnknown(data['dosage']!, _dosageMeta));
    }
    if (data.containsKey('frequency')) {
      context.handle(_frequencyMeta,
          frequency.isAcceptableOrUnknown(data['frequency']!, _frequencyMeta));
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {itemId};
  @override
  PrescriptionItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PrescriptionItem(
      itemId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}item_id'])!,
      prescriptionId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}prescription_id'])!,
      medicationId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}medication_id'])!,
      dosage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dosage']),
      frequency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}frequency']),
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
    );
  }

  @override
  $PrescriptionItemsTable createAlias(String alias) {
    return $PrescriptionItemsTable(attachedDatabase, alias);
  }
}

class PrescriptionItem extends DataClass
    implements Insertable<PrescriptionItem> {
  final int itemId;
  final int prescriptionId;
  final int medicationId;
  final String? dosage;
  final String? frequency;
  final int quantity;
  const PrescriptionItem(
      {required this.itemId,
      required this.prescriptionId,
      required this.medicationId,
      this.dosage,
      this.frequency,
      required this.quantity});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['item_id'] = Variable<int>(itemId);
    map['prescription_id'] = Variable<int>(prescriptionId);
    map['medication_id'] = Variable<int>(medicationId);
    if (!nullToAbsent || dosage != null) {
      map['dosage'] = Variable<String>(dosage);
    }
    if (!nullToAbsent || frequency != null) {
      map['frequency'] = Variable<String>(frequency);
    }
    map['quantity'] = Variable<int>(quantity);
    return map;
  }

  PrescriptionItemsCompanion toCompanion(bool nullToAbsent) {
    return PrescriptionItemsCompanion(
      itemId: Value(itemId),
      prescriptionId: Value(prescriptionId),
      medicationId: Value(medicationId),
      dosage:
          dosage == null && nullToAbsent ? const Value.absent() : Value(dosage),
      frequency: frequency == null && nullToAbsent
          ? const Value.absent()
          : Value(frequency),
      quantity: Value(quantity),
    );
  }

  factory PrescriptionItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PrescriptionItem(
      itemId: serializer.fromJson<int>(json['itemId']),
      prescriptionId: serializer.fromJson<int>(json['prescriptionId']),
      medicationId: serializer.fromJson<int>(json['medicationId']),
      dosage: serializer.fromJson<String?>(json['dosage']),
      frequency: serializer.fromJson<String?>(json['frequency']),
      quantity: serializer.fromJson<int>(json['quantity']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'itemId': serializer.toJson<int>(itemId),
      'prescriptionId': serializer.toJson<int>(prescriptionId),
      'medicationId': serializer.toJson<int>(medicationId),
      'dosage': serializer.toJson<String?>(dosage),
      'frequency': serializer.toJson<String?>(frequency),
      'quantity': serializer.toJson<int>(quantity),
    };
  }

  PrescriptionItem copyWith(
          {int? itemId,
          int? prescriptionId,
          int? medicationId,
          Value<String?> dosage = const Value.absent(),
          Value<String?> frequency = const Value.absent(),
          int? quantity}) =>
      PrescriptionItem(
        itemId: itemId ?? this.itemId,
        prescriptionId: prescriptionId ?? this.prescriptionId,
        medicationId: medicationId ?? this.medicationId,
        dosage: dosage.present ? dosage.value : this.dosage,
        frequency: frequency.present ? frequency.value : this.frequency,
        quantity: quantity ?? this.quantity,
      );
  PrescriptionItem copyWithCompanion(PrescriptionItemsCompanion data) {
    return PrescriptionItem(
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      prescriptionId: data.prescriptionId.present
          ? data.prescriptionId.value
          : this.prescriptionId,
      medicationId: data.medicationId.present
          ? data.medicationId.value
          : this.medicationId,
      dosage: data.dosage.present ? data.dosage.value : this.dosage,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PrescriptionItem(')
          ..write('itemId: $itemId, ')
          ..write('prescriptionId: $prescriptionId, ')
          ..write('medicationId: $medicationId, ')
          ..write('dosage: $dosage, ')
          ..write('frequency: $frequency, ')
          ..write('quantity: $quantity')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      itemId, prescriptionId, medicationId, dosage, frequency, quantity);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PrescriptionItem &&
          other.itemId == this.itemId &&
          other.prescriptionId == this.prescriptionId &&
          other.medicationId == this.medicationId &&
          other.dosage == this.dosage &&
          other.frequency == this.frequency &&
          other.quantity == this.quantity);
}

class PrescriptionItemsCompanion extends UpdateCompanion<PrescriptionItem> {
  final Value<int> itemId;
  final Value<int> prescriptionId;
  final Value<int> medicationId;
  final Value<String?> dosage;
  final Value<String?> frequency;
  final Value<int> quantity;
  const PrescriptionItemsCompanion({
    this.itemId = const Value.absent(),
    this.prescriptionId = const Value.absent(),
    this.medicationId = const Value.absent(),
    this.dosage = const Value.absent(),
    this.frequency = const Value.absent(),
    this.quantity = const Value.absent(),
  });
  PrescriptionItemsCompanion.insert({
    this.itemId = const Value.absent(),
    required int prescriptionId,
    required int medicationId,
    this.dosage = const Value.absent(),
    this.frequency = const Value.absent(),
    this.quantity = const Value.absent(),
  })  : prescriptionId = Value(prescriptionId),
        medicationId = Value(medicationId);
  static Insertable<PrescriptionItem> custom({
    Expression<int>? itemId,
    Expression<int>? prescriptionId,
    Expression<int>? medicationId,
    Expression<String>? dosage,
    Expression<String>? frequency,
    Expression<int>? quantity,
  }) {
    return RawValuesInsertable({
      if (itemId != null) 'item_id': itemId,
      if (prescriptionId != null) 'prescription_id': prescriptionId,
      if (medicationId != null) 'medication_id': medicationId,
      if (dosage != null) 'dosage': dosage,
      if (frequency != null) 'frequency': frequency,
      if (quantity != null) 'quantity': quantity,
    });
  }

  PrescriptionItemsCompanion copyWith(
      {Value<int>? itemId,
      Value<int>? prescriptionId,
      Value<int>? medicationId,
      Value<String?>? dosage,
      Value<String?>? frequency,
      Value<int>? quantity}) {
    return PrescriptionItemsCompanion(
      itemId: itemId ?? this.itemId,
      prescriptionId: prescriptionId ?? this.prescriptionId,
      medicationId: medicationId ?? this.medicationId,
      dosage: dosage ?? this.dosage,
      frequency: frequency ?? this.frequency,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (itemId.present) {
      map['item_id'] = Variable<int>(itemId.value);
    }
    if (prescriptionId.present) {
      map['prescription_id'] = Variable<int>(prescriptionId.value);
    }
    if (medicationId.present) {
      map['medication_id'] = Variable<int>(medicationId.value);
    }
    if (dosage.present) {
      map['dosage'] = Variable<String>(dosage.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<String>(frequency.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PrescriptionItemsCompanion(')
          ..write('itemId: $itemId, ')
          ..write('prescriptionId: $prescriptionId, ')
          ..write('medicationId: $medicationId, ')
          ..write('dosage: $dosage, ')
          ..write('frequency: $frequency, ')
          ..write('quantity: $quantity')
          ..write(')'))
        .toString();
  }
}

class $FeedbacksTable extends Feedbacks
    with TableInfo<$FeedbacksTable, Feedback> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeedbacksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _messageMeta =
      const VerificationMeta('message');
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
      'message', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [id, userId, message, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'feedbacks';
  @override
  VerificationContext validateIntegrity(Insertable<Feedback> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('message')) {
      context.handle(_messageMeta,
          message.isAcceptableOrUnknown(data['message']!, _messageMeta));
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Feedback map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Feedback(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      message: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}message'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $FeedbacksTable createAlias(String alias) {
    return $FeedbacksTable(attachedDatabase, alias);
  }
}

class Feedback extends DataClass implements Insertable<Feedback> {
  final int id;
  final int userId;
  final String message;
  final DateTime createdAt;
  const Feedback(
      {required this.id,
      required this.userId,
      required this.message,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['message'] = Variable<String>(message);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FeedbacksCompanion toCompanion(bool nullToAbsent) {
    return FeedbacksCompanion(
      id: Value(id),
      userId: Value(userId),
      message: Value(message),
      createdAt: Value(createdAt),
    );
  }

  factory Feedback.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Feedback(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      message: serializer.fromJson<String>(json['message']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'message': serializer.toJson<String>(message),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Feedback copyWith(
          {int? id, int? userId, String? message, DateTime? createdAt}) =>
      Feedback(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        message: message ?? this.message,
        createdAt: createdAt ?? this.createdAt,
      );
  Feedback copyWithCompanion(FeedbacksCompanion data) {
    return Feedback(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      message: data.message.present ? data.message.value : this.message,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Feedback(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('message: $message, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, message, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Feedback &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.message == this.message &&
          other.createdAt == this.createdAt);
}

class FeedbacksCompanion extends UpdateCompanion<Feedback> {
  final Value<int> id;
  final Value<int> userId;
  final Value<String> message;
  final Value<DateTime> createdAt;
  const FeedbacksCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.message = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  FeedbacksCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required String message,
    this.createdAt = const Value.absent(),
  })  : userId = Value(userId),
        message = Value(message);
  static Insertable<Feedback> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<String>? message,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (message != null) 'message': message,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  FeedbacksCompanion copyWith(
      {Value<int>? id,
      Value<int>? userId,
      Value<String>? message,
      Value<DateTime>? createdAt}) {
    return FeedbacksCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FeedbacksCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('message: $message, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $AuditLogsTable extends AuditLogs
    with TableInfo<$AuditLogsTable, AuditLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuditLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
      'action', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _detailsMeta =
      const VerificationMeta('details');
  @override
  late final GeneratedColumn<String> details = GeneratedColumn<String>(
      'details', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, userId, action, details, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'audit_logs';
  @override
  VerificationContext validateIntegrity(Insertable<AuditLog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('action')) {
      context.handle(_actionMeta,
          action.isAcceptableOrUnknown(data['action']!, _actionMeta));
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('details')) {
      context.handle(_detailsMeta,
          details.isAcceptableOrUnknown(data['details']!, _detailsMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AuditLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuditLog(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      action: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}action'])!,
      details: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}details']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $AuditLogsTable createAlias(String alias) {
    return $AuditLogsTable(attachedDatabase, alias);
  }
}

class AuditLog extends DataClass implements Insertable<AuditLog> {
  final int id;
  final int userId;
  final String action;
  final String? details;
  final DateTime createdAt;
  const AuditLog(
      {required this.id,
      required this.userId,
      required this.action,
      this.details,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['action'] = Variable<String>(action);
    if (!nullToAbsent || details != null) {
      map['details'] = Variable<String>(details);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AuditLogsCompanion toCompanion(bool nullToAbsent) {
    return AuditLogsCompanion(
      id: Value(id),
      userId: Value(userId),
      action: Value(action),
      details: details == null && nullToAbsent
          ? const Value.absent()
          : Value(details),
      createdAt: Value(createdAt),
    );
  }

  factory AuditLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuditLog(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      action: serializer.fromJson<String>(json['action']),
      details: serializer.fromJson<String?>(json['details']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'action': serializer.toJson<String>(action),
      'details': serializer.toJson<String?>(details),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AuditLog copyWith(
          {int? id,
          int? userId,
          String? action,
          Value<String?> details = const Value.absent(),
          DateTime? createdAt}) =>
      AuditLog(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        action: action ?? this.action,
        details: details.present ? details.value : this.details,
        createdAt: createdAt ?? this.createdAt,
      );
  AuditLog copyWithCompanion(AuditLogsCompanion data) {
    return AuditLog(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      action: data.action.present ? data.action.value : this.action,
      details: data.details.present ? data.details.value : this.details,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuditLog(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('action: $action, ')
          ..write('details: $details, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, action, details, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuditLog &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.action == this.action &&
          other.details == this.details &&
          other.createdAt == this.createdAt);
}

class AuditLogsCompanion extends UpdateCompanion<AuditLog> {
  final Value<int> id;
  final Value<int> userId;
  final Value<String> action;
  final Value<String?> details;
  final Value<DateTime> createdAt;
  const AuditLogsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.action = const Value.absent(),
    this.details = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  AuditLogsCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required String action,
    this.details = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : userId = Value(userId),
        action = Value(action);
  static Insertable<AuditLog> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<String>? action,
    Expression<String>? details,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (action != null) 'action': action,
      if (details != null) 'details': details,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  AuditLogsCompanion copyWith(
      {Value<int>? id,
      Value<int>? userId,
      Value<String>? action,
      Value<String?>? details,
      Value<DateTime>? createdAt}) {
    return AuditLogsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      action: action ?? this.action,
      details: details ?? this.details,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (details.present) {
      map['details'] = Variable<String>(details.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuditLogsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('action: $action, ')
          ..write('details: $details, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $EmergencyAccessRequestsTable extends EmergencyAccessRequests
    with TableInfo<$EmergencyAccessRequestsTable, EmergencyAccessRequest> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmergencyAccessRequestsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _patientIdMeta =
      const VerificationMeta('patientId');
  @override
  late final GeneratedColumn<int> patientId = GeneratedColumn<int>(
      'patient_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _physicianIdMeta =
      const VerificationMeta('physicianId');
  @override
  late final GeneratedColumn<int> physicianId = GeneratedColumn<int>(
      'physician_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
      'reason', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, patientId, physicianId, reason, status, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'emergency_access_requests';
  @override
  VerificationContext validateIntegrity(
      Insertable<EmergencyAccessRequest> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('patient_id')) {
      context.handle(_patientIdMeta,
          patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta));
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('physician_id')) {
      context.handle(
          _physicianIdMeta,
          physicianId.isAcceptableOrUnknown(
              data['physician_id']!, _physicianIdMeta));
    } else if (isInserting) {
      context.missing(_physicianIdMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(_reasonMeta,
          reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta));
    } else if (isInserting) {
      context.missing(_reasonMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EmergencyAccessRequest map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EmergencyAccessRequest(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      patientId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}patient_id'])!,
      physicianId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}physician_id'])!,
      reason: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reason'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $EmergencyAccessRequestsTable createAlias(String alias) {
    return $EmergencyAccessRequestsTable(attachedDatabase, alias);
  }
}

class EmergencyAccessRequest extends DataClass
    implements Insertable<EmergencyAccessRequest> {
  final int id;
  final int patientId;
  final int physicianId;
  final String reason;
  final String status;
  final DateTime createdAt;
  const EmergencyAccessRequest(
      {required this.id,
      required this.patientId,
      required this.physicianId,
      required this.reason,
      required this.status,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['patient_id'] = Variable<int>(patientId);
    map['physician_id'] = Variable<int>(physicianId);
    map['reason'] = Variable<String>(reason);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  EmergencyAccessRequestsCompanion toCompanion(bool nullToAbsent) {
    return EmergencyAccessRequestsCompanion(
      id: Value(id),
      patientId: Value(patientId),
      physicianId: Value(physicianId),
      reason: Value(reason),
      status: Value(status),
      createdAt: Value(createdAt),
    );
  }

  factory EmergencyAccessRequest.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EmergencyAccessRequest(
      id: serializer.fromJson<int>(json['id']),
      patientId: serializer.fromJson<int>(json['patientId']),
      physicianId: serializer.fromJson<int>(json['physicianId']),
      reason: serializer.fromJson<String>(json['reason']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'patientId': serializer.toJson<int>(patientId),
      'physicianId': serializer.toJson<int>(physicianId),
      'reason': serializer.toJson<String>(reason),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  EmergencyAccessRequest copyWith(
          {int? id,
          int? patientId,
          int? physicianId,
          String? reason,
          String? status,
          DateTime? createdAt}) =>
      EmergencyAccessRequest(
        id: id ?? this.id,
        patientId: patientId ?? this.patientId,
        physicianId: physicianId ?? this.physicianId,
        reason: reason ?? this.reason,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
      );
  EmergencyAccessRequest copyWithCompanion(
      EmergencyAccessRequestsCompanion data) {
    return EmergencyAccessRequest(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      physicianId:
          data.physicianId.present ? data.physicianId.value : this.physicianId,
      reason: data.reason.present ? data.reason.value : this.reason,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EmergencyAccessRequest(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('physicianId: $physicianId, ')
          ..write('reason: $reason, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, patientId, physicianId, reason, status, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EmergencyAccessRequest &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.physicianId == this.physicianId &&
          other.reason == this.reason &&
          other.status == this.status &&
          other.createdAt == this.createdAt);
}

class EmergencyAccessRequestsCompanion
    extends UpdateCompanion<EmergencyAccessRequest> {
  final Value<int> id;
  final Value<int> patientId;
  final Value<int> physicianId;
  final Value<String> reason;
  final Value<String> status;
  final Value<DateTime> createdAt;
  const EmergencyAccessRequestsCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.physicianId = const Value.absent(),
    this.reason = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  EmergencyAccessRequestsCompanion.insert({
    this.id = const Value.absent(),
    required int patientId,
    required int physicianId,
    required String reason,
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : patientId = Value(patientId),
        physicianId = Value(physicianId),
        reason = Value(reason);
  static Insertable<EmergencyAccessRequest> custom({
    Expression<int>? id,
    Expression<int>? patientId,
    Expression<int>? physicianId,
    Expression<String>? reason,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (physicianId != null) 'physician_id': physicianId,
      if (reason != null) 'reason': reason,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  EmergencyAccessRequestsCompanion copyWith(
      {Value<int>? id,
      Value<int>? patientId,
      Value<int>? physicianId,
      Value<String>? reason,
      Value<String>? status,
      Value<DateTime>? createdAt}) {
    return EmergencyAccessRequestsCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      physicianId: physicianId ?? this.physicianId,
      reason: reason ?? this.reason,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<int>(patientId.value);
    }
    if (physicianId.present) {
      map['physician_id'] = Variable<int>(physicianId.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmergencyAccessRequestsCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('physicianId: $physicianId, ')
          ..write('reason: $reason, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $InsurancesTable extends Insurances
    with TableInfo<$InsurancesTable, Insurance> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InsurancesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _detailsMeta =
      const VerificationMeta('details');
  @override
  late final GeneratedColumn<String> details = GeneratedColumn<String>(
      'details', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, details];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'insurances';
  @override
  VerificationContext validateIntegrity(Insertable<Insurance> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('details')) {
      context.handle(_detailsMeta,
          details.isAcceptableOrUnknown(data['details']!, _detailsMeta));
    } else if (isInserting) {
      context.missing(_detailsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Insurance map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Insurance(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      details: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}details'])!,
    );
  }

  @override
  $InsurancesTable createAlias(String alias) {
    return $InsurancesTable(attachedDatabase, alias);
  }
}

class Insurance extends DataClass implements Insertable<Insurance> {
  final int id;
  final String name;
  final String details;
  const Insurance(
      {required this.id, required this.name, required this.details});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['details'] = Variable<String>(details);
    return map;
  }

  InsurancesCompanion toCompanion(bool nullToAbsent) {
    return InsurancesCompanion(
      id: Value(id),
      name: Value(name),
      details: Value(details),
    );
  }

  factory Insurance.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Insurance(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      details: serializer.fromJson<String>(json['details']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'details': serializer.toJson<String>(details),
    };
  }

  Insurance copyWith({int? id, String? name, String? details}) => Insurance(
        id: id ?? this.id,
        name: name ?? this.name,
        details: details ?? this.details,
      );
  Insurance copyWithCompanion(InsurancesCompanion data) {
    return Insurance(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      details: data.details.present ? data.details.value : this.details,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Insurance(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('details: $details')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, details);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Insurance &&
          other.id == this.id &&
          other.name == this.name &&
          other.details == this.details);
}

class InsurancesCompanion extends UpdateCompanion<Insurance> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> details;
  const InsurancesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.details = const Value.absent(),
  });
  InsurancesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String details,
  })  : name = Value(name),
        details = Value(details);
  static Insertable<Insurance> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? details,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (details != null) 'details': details,
    });
  }

  InsurancesCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<String>? details}) {
    return InsurancesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      details: details ?? this.details,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (details.present) {
      map['details'] = Variable<String>(details.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InsurancesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('details: $details')
          ..write(')'))
        .toString();
  }
}

class $PharmacyInsurancesTable extends PharmacyInsurances
    with TableInfo<$PharmacyInsurancesTable, PharmacyInsurance> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PharmacyInsurancesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _pharmacyIdMeta =
      const VerificationMeta('pharmacyId');
  @override
  late final GeneratedColumn<int> pharmacyId = GeneratedColumn<int>(
      'pharmacy_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _insuranceIdMeta =
      const VerificationMeta('insuranceId');
  @override
  late final GeneratedColumn<int> insuranceId = GeneratedColumn<int>(
      'insurance_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, pharmacyId, insuranceId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pharmacy_insurances';
  @override
  VerificationContext validateIntegrity(Insertable<PharmacyInsurance> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('pharmacy_id')) {
      context.handle(
          _pharmacyIdMeta,
          pharmacyId.isAcceptableOrUnknown(
              data['pharmacy_id']!, _pharmacyIdMeta));
    } else if (isInserting) {
      context.missing(_pharmacyIdMeta);
    }
    if (data.containsKey('insurance_id')) {
      context.handle(
          _insuranceIdMeta,
          insuranceId.isAcceptableOrUnknown(
              data['insurance_id']!, _insuranceIdMeta));
    } else if (isInserting) {
      context.missing(_insuranceIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PharmacyInsurance map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PharmacyInsurance(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      pharmacyId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}pharmacy_id'])!,
      insuranceId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}insurance_id'])!,
    );
  }

  @override
  $PharmacyInsurancesTable createAlias(String alias) {
    return $PharmacyInsurancesTable(attachedDatabase, alias);
  }
}

class PharmacyInsurance extends DataClass
    implements Insertable<PharmacyInsurance> {
  final int id;
  final int pharmacyId;
  final int insuranceId;
  const PharmacyInsurance(
      {required this.id, required this.pharmacyId, required this.insuranceId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['pharmacy_id'] = Variable<int>(pharmacyId);
    map['insurance_id'] = Variable<int>(insuranceId);
    return map;
  }

  PharmacyInsurancesCompanion toCompanion(bool nullToAbsent) {
    return PharmacyInsurancesCompanion(
      id: Value(id),
      pharmacyId: Value(pharmacyId),
      insuranceId: Value(insuranceId),
    );
  }

  factory PharmacyInsurance.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PharmacyInsurance(
      id: serializer.fromJson<int>(json['id']),
      pharmacyId: serializer.fromJson<int>(json['pharmacyId']),
      insuranceId: serializer.fromJson<int>(json['insuranceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'pharmacyId': serializer.toJson<int>(pharmacyId),
      'insuranceId': serializer.toJson<int>(insuranceId),
    };
  }

  PharmacyInsurance copyWith({int? id, int? pharmacyId, int? insuranceId}) =>
      PharmacyInsurance(
        id: id ?? this.id,
        pharmacyId: pharmacyId ?? this.pharmacyId,
        insuranceId: insuranceId ?? this.insuranceId,
      );
  PharmacyInsurance copyWithCompanion(PharmacyInsurancesCompanion data) {
    return PharmacyInsurance(
      id: data.id.present ? data.id.value : this.id,
      pharmacyId:
          data.pharmacyId.present ? data.pharmacyId.value : this.pharmacyId,
      insuranceId:
          data.insuranceId.present ? data.insuranceId.value : this.insuranceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PharmacyInsurance(')
          ..write('id: $id, ')
          ..write('pharmacyId: $pharmacyId, ')
          ..write('insuranceId: $insuranceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, pharmacyId, insuranceId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PharmacyInsurance &&
          other.id == this.id &&
          other.pharmacyId == this.pharmacyId &&
          other.insuranceId == this.insuranceId);
}

class PharmacyInsurancesCompanion extends UpdateCompanion<PharmacyInsurance> {
  final Value<int> id;
  final Value<int> pharmacyId;
  final Value<int> insuranceId;
  const PharmacyInsurancesCompanion({
    this.id = const Value.absent(),
    this.pharmacyId = const Value.absent(),
    this.insuranceId = const Value.absent(),
  });
  PharmacyInsurancesCompanion.insert({
    this.id = const Value.absent(),
    required int pharmacyId,
    required int insuranceId,
  })  : pharmacyId = Value(pharmacyId),
        insuranceId = Value(insuranceId);
  static Insertable<PharmacyInsurance> custom({
    Expression<int>? id,
    Expression<int>? pharmacyId,
    Expression<int>? insuranceId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pharmacyId != null) 'pharmacy_id': pharmacyId,
      if (insuranceId != null) 'insurance_id': insuranceId,
    });
  }

  PharmacyInsurancesCompanion copyWith(
      {Value<int>? id, Value<int>? pharmacyId, Value<int>? insuranceId}) {
    return PharmacyInsurancesCompanion(
      id: id ?? this.id,
      pharmacyId: pharmacyId ?? this.pharmacyId,
      insuranceId: insuranceId ?? this.insuranceId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (pharmacyId.present) {
      map['pharmacy_id'] = Variable<int>(pharmacyId.value);
    }
    if (insuranceId.present) {
      map['insurance_id'] = Variable<int>(insuranceId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PharmacyInsurancesCompanion(')
          ..write('id: $id, ')
          ..write('pharmacyId: $pharmacyId, ')
          ..write('insuranceId: $insuranceId')
          ..write(')'))
        .toString();
  }
}

class $BlockchainTransactionsTable extends BlockchainTransactions
    with TableInfo<$BlockchainTransactionsTable, BlockchainTransaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BlockchainTransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _prescriptionIdMeta =
      const VerificationMeta('prescriptionId');
  @override
  late final GeneratedColumn<int> prescriptionId = GeneratedColumn<int>(
      'prescription_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _transactionHashMeta =
      const VerificationMeta('transactionHash');
  @override
  late final GeneratedColumn<String> transactionHash = GeneratedColumn<String>(
      'transaction_hash', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, prescriptionId, transactionHash, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'blockchain_transactions';
  @override
  VerificationContext validateIntegrity(
      Insertable<BlockchainTransaction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('prescription_id')) {
      context.handle(
          _prescriptionIdMeta,
          prescriptionId.isAcceptableOrUnknown(
              data['prescription_id']!, _prescriptionIdMeta));
    } else if (isInserting) {
      context.missing(_prescriptionIdMeta);
    }
    if (data.containsKey('transaction_hash')) {
      context.handle(
          _transactionHashMeta,
          transactionHash.isAcceptableOrUnknown(
              data['transaction_hash']!, _transactionHashMeta));
    } else if (isInserting) {
      context.missing(_transactionHashMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BlockchainTransaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BlockchainTransaction(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      prescriptionId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}prescription_id'])!,
      transactionHash: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}transaction_hash'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $BlockchainTransactionsTable createAlias(String alias) {
    return $BlockchainTransactionsTable(attachedDatabase, alias);
  }
}

class BlockchainTransaction extends DataClass
    implements Insertable<BlockchainTransaction> {
  final int id;
  final int prescriptionId;
  final String transactionHash;
  final DateTime createdAt;
  const BlockchainTransaction(
      {required this.id,
      required this.prescriptionId,
      required this.transactionHash,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['prescription_id'] = Variable<int>(prescriptionId);
    map['transaction_hash'] = Variable<String>(transactionHash);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BlockchainTransactionsCompanion toCompanion(bool nullToAbsent) {
    return BlockchainTransactionsCompanion(
      id: Value(id),
      prescriptionId: Value(prescriptionId),
      transactionHash: Value(transactionHash),
      createdAt: Value(createdAt),
    );
  }

  factory BlockchainTransaction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BlockchainTransaction(
      id: serializer.fromJson<int>(json['id']),
      prescriptionId: serializer.fromJson<int>(json['prescriptionId']),
      transactionHash: serializer.fromJson<String>(json['transactionHash']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'prescriptionId': serializer.toJson<int>(prescriptionId),
      'transactionHash': serializer.toJson<String>(transactionHash),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  BlockchainTransaction copyWith(
          {int? id,
          int? prescriptionId,
          String? transactionHash,
          DateTime? createdAt}) =>
      BlockchainTransaction(
        id: id ?? this.id,
        prescriptionId: prescriptionId ?? this.prescriptionId,
        transactionHash: transactionHash ?? this.transactionHash,
        createdAt: createdAt ?? this.createdAt,
      );
  BlockchainTransaction copyWithCompanion(
      BlockchainTransactionsCompanion data) {
    return BlockchainTransaction(
      id: data.id.present ? data.id.value : this.id,
      prescriptionId: data.prescriptionId.present
          ? data.prescriptionId.value
          : this.prescriptionId,
      transactionHash: data.transactionHash.present
          ? data.transactionHash.value
          : this.transactionHash,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BlockchainTransaction(')
          ..write('id: $id, ')
          ..write('prescriptionId: $prescriptionId, ')
          ..write('transactionHash: $transactionHash, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, prescriptionId, transactionHash, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BlockchainTransaction &&
          other.id == this.id &&
          other.prescriptionId == this.prescriptionId &&
          other.transactionHash == this.transactionHash &&
          other.createdAt == this.createdAt);
}

class BlockchainTransactionsCompanion
    extends UpdateCompanion<BlockchainTransaction> {
  final Value<int> id;
  final Value<int> prescriptionId;
  final Value<String> transactionHash;
  final Value<DateTime> createdAt;
  const BlockchainTransactionsCompanion({
    this.id = const Value.absent(),
    this.prescriptionId = const Value.absent(),
    this.transactionHash = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  BlockchainTransactionsCompanion.insert({
    this.id = const Value.absent(),
    required int prescriptionId,
    required String transactionHash,
    this.createdAt = const Value.absent(),
  })  : prescriptionId = Value(prescriptionId),
        transactionHash = Value(transactionHash);
  static Insertable<BlockchainTransaction> custom({
    Expression<int>? id,
    Expression<int>? prescriptionId,
    Expression<String>? transactionHash,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (prescriptionId != null) 'prescription_id': prescriptionId,
      if (transactionHash != null) 'transaction_hash': transactionHash,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  BlockchainTransactionsCompanion copyWith(
      {Value<int>? id,
      Value<int>? prescriptionId,
      Value<String>? transactionHash,
      Value<DateTime>? createdAt}) {
    return BlockchainTransactionsCompanion(
      id: id ?? this.id,
      prescriptionId: prescriptionId ?? this.prescriptionId,
      transactionHash: transactionHash ?? this.transactionHash,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (prescriptionId.present) {
      map['prescription_id'] = Variable<int>(prescriptionId.value);
    }
    if (transactionHash.present) {
      map['transaction_hash'] = Variable<String>(transactionHash.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BlockchainTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('prescriptionId: $prescriptionId, ')
          ..write('transactionHash: $transactionHash, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PharmacistTable extends Pharmacist
    with TableInfo<$PharmacistTable, PharmacistData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PharmacistTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _pharmacyIdMeta =
      const VerificationMeta('pharmacyId');
  @override
  late final GeneratedColumn<int> pharmacyId = GeneratedColumn<int>(
      'pharmacy_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _pharmacistIdMeta =
      const VerificationMeta('pharmacistId');
  @override
  late final GeneratedColumn<int> pharmacistId = GeneratedColumn<int>(
      'pharmacist_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, pharmacyId, pharmacistId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pharmacist';
  @override
  VerificationContext validateIntegrity(Insertable<PharmacistData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('pharmacy_id')) {
      context.handle(
          _pharmacyIdMeta,
          pharmacyId.isAcceptableOrUnknown(
              data['pharmacy_id']!, _pharmacyIdMeta));
    } else if (isInserting) {
      context.missing(_pharmacyIdMeta);
    }
    if (data.containsKey('pharmacist_id')) {
      context.handle(
          _pharmacistIdMeta,
          pharmacistId.isAcceptableOrUnknown(
              data['pharmacist_id']!, _pharmacistIdMeta));
    } else if (isInserting) {
      context.missing(_pharmacistIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PharmacistData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PharmacistData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      pharmacyId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}pharmacy_id'])!,
      pharmacistId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}pharmacist_id'])!,
    );
  }

  @override
  $PharmacistTable createAlias(String alias) {
    return $PharmacistTable(attachedDatabase, alias);
  }
}

class PharmacistData extends DataClass implements Insertable<PharmacistData> {
  final int id;
  final int pharmacyId;
  final int pharmacistId;
  const PharmacistData(
      {required this.id, required this.pharmacyId, required this.pharmacistId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['pharmacy_id'] = Variable<int>(pharmacyId);
    map['pharmacist_id'] = Variable<int>(pharmacistId);
    return map;
  }

  PharmacistCompanion toCompanion(bool nullToAbsent) {
    return PharmacistCompanion(
      id: Value(id),
      pharmacyId: Value(pharmacyId),
      pharmacistId: Value(pharmacistId),
    );
  }

  factory PharmacistData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PharmacistData(
      id: serializer.fromJson<int>(json['id']),
      pharmacyId: serializer.fromJson<int>(json['pharmacyId']),
      pharmacistId: serializer.fromJson<int>(json['pharmacistId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'pharmacyId': serializer.toJson<int>(pharmacyId),
      'pharmacistId': serializer.toJson<int>(pharmacistId),
    };
  }

  PharmacistData copyWith({int? id, int? pharmacyId, int? pharmacistId}) =>
      PharmacistData(
        id: id ?? this.id,
        pharmacyId: pharmacyId ?? this.pharmacyId,
        pharmacistId: pharmacistId ?? this.pharmacistId,
      );
  PharmacistData copyWithCompanion(PharmacistCompanion data) {
    return PharmacistData(
      id: data.id.present ? data.id.value : this.id,
      pharmacyId:
          data.pharmacyId.present ? data.pharmacyId.value : this.pharmacyId,
      pharmacistId: data.pharmacistId.present
          ? data.pharmacistId.value
          : this.pharmacistId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PharmacistData(')
          ..write('id: $id, ')
          ..write('pharmacyId: $pharmacyId, ')
          ..write('pharmacistId: $pharmacistId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, pharmacyId, pharmacistId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PharmacistData &&
          other.id == this.id &&
          other.pharmacyId == this.pharmacyId &&
          other.pharmacistId == this.pharmacistId);
}

class PharmacistCompanion extends UpdateCompanion<PharmacistData> {
  final Value<int> id;
  final Value<int> pharmacyId;
  final Value<int> pharmacistId;
  const PharmacistCompanion({
    this.id = const Value.absent(),
    this.pharmacyId = const Value.absent(),
    this.pharmacistId = const Value.absent(),
  });
  PharmacistCompanion.insert({
    this.id = const Value.absent(),
    required int pharmacyId,
    required int pharmacistId,
  })  : pharmacyId = Value(pharmacyId),
        pharmacistId = Value(pharmacistId);
  static Insertable<PharmacistData> custom({
    Expression<int>? id,
    Expression<int>? pharmacyId,
    Expression<int>? pharmacistId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pharmacyId != null) 'pharmacy_id': pharmacyId,
      if (pharmacistId != null) 'pharmacist_id': pharmacistId,
    });
  }

  PharmacistCompanion copyWith(
      {Value<int>? id, Value<int>? pharmacyId, Value<int>? pharmacistId}) {
    return PharmacistCompanion(
      id: id ?? this.id,
      pharmacyId: pharmacyId ?? this.pharmacyId,
      pharmacistId: pharmacistId ?? this.pharmacistId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (pharmacyId.present) {
      map['pharmacy_id'] = Variable<int>(pharmacyId.value);
    }
    if (pharmacistId.present) {
      map['pharmacist_id'] = Variable<int>(pharmacistId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PharmacistCompanion(')
          ..write('id: $id, ')
          ..write('pharmacyId: $pharmacyId, ')
          ..write('pharmacistId: $pharmacistId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $PharmaciesTable pharmacies = $PharmaciesTable(this);
  late final $MedicationsTable medications = $MedicationsTable(this);
  late final $InventoryTable inventory = $InventoryTable(this);
  late final $PrescriptionsTable prescriptions = $PrescriptionsTable(this);
  late final $PrescriptionItemsTable prescriptionItems =
      $PrescriptionItemsTable(this);
  late final $FeedbacksTable feedbacks = $FeedbacksTable(this);
  late final $AuditLogsTable auditLogs = $AuditLogsTable(this);
  late final $EmergencyAccessRequestsTable emergencyAccessRequests =
      $EmergencyAccessRequestsTable(this);
  late final $InsurancesTable insurances = $InsurancesTable(this);
  late final $PharmacyInsurancesTable pharmacyInsurances =
      $PharmacyInsurancesTable(this);
  late final $BlockchainTransactionsTable blockchainTransactions =
      $BlockchainTransactionsTable(this);
  late final $PharmacistTable pharmacist = $PharmacistTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        users,
        pharmacies,
        medications,
        inventory,
        prescriptions,
        prescriptionItems,
        feedbacks,
        auditLogs,
        emergencyAccessRequests,
        insurances,
        pharmacyInsurances,
        blockchainTransactions,
        pharmacist
      ];
}

typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  required String firstName,
  required String lastName,
  required String email,
  required String phone,
  required String nationalId,
  Value<String?> syndicateNumber,
  required String passwordHash,
  required String role,
  Value<DateTime> createdAt,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  Value<String> firstName,
  Value<String> lastName,
  Value<String> email,
  Value<String> phone,
  Value<String> nationalId,
  Value<String?> syndicateNumber,
  Value<String> passwordHash,
  Value<String> role,
  Value<DateTime> createdAt,
});

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get firstName => $composableBuilder(
      column: $table.firstName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastName => $composableBuilder(
      column: $table.lastName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nationalId => $composableBuilder(
      column: $table.nationalId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syndicateNumber => $composableBuilder(
      column: $table.syndicateNumber,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get passwordHash => $composableBuilder(
      column: $table.passwordHash, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get firstName => $composableBuilder(
      column: $table.firstName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastName => $composableBuilder(
      column: $table.lastName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nationalId => $composableBuilder(
      column: $table.nationalId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syndicateNumber => $composableBuilder(
      column: $table.syndicateNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get passwordHash => $composableBuilder(
      column: $table.passwordHash,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get nationalId => $composableBuilder(
      column: $table.nationalId, builder: (column) => column);

  GeneratedColumn<String> get syndicateNumber => $composableBuilder(
      column: $table.syndicateNumber, builder: (column) => column);

  GeneratedColumn<String> get passwordHash => $composableBuilder(
      column: $table.passwordHash, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$UsersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
    User,
    PrefetchHooks Function()> {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> firstName = const Value.absent(),
            Value<String> lastName = const Value.absent(),
            Value<String> email = const Value.absent(),
            Value<String> phone = const Value.absent(),
            Value<String> nationalId = const Value.absent(),
            Value<String?> syndicateNumber = const Value.absent(),
            Value<String> passwordHash = const Value.absent(),
            Value<String> role = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              UsersCompanion(
            id: id,
            firstName: firstName,
            lastName: lastName,
            email: email,
            phone: phone,
            nationalId: nationalId,
            syndicateNumber: syndicateNumber,
            passwordHash: passwordHash,
            role: role,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String firstName,
            required String lastName,
            required String email,
            required String phone,
            required String nationalId,
            Value<String?> syndicateNumber = const Value.absent(),
            required String passwordHash,
            required String role,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              UsersCompanion.insert(
            id: id,
            firstName: firstName,
            lastName: lastName,
            email: email,
            phone: phone,
            nationalId: nationalId,
            syndicateNumber: syndicateNumber,
            passwordHash: passwordHash,
            role: role,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UsersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
    User,
    PrefetchHooks Function()>;
typedef $$PharmaciesTableCreateCompanionBuilder = PharmaciesCompanion Function({
  Value<int> pharmacyId,
  required String name,
  Value<String?> address,
  Value<String?> phone,
  Value<double?> latitude,
  Value<double?> longitude,
  Value<bool> acceptsInsurance,
});
typedef $$PharmaciesTableUpdateCompanionBuilder = PharmaciesCompanion Function({
  Value<int> pharmacyId,
  Value<String> name,
  Value<String?> address,
  Value<String?> phone,
  Value<double?> latitude,
  Value<double?> longitude,
  Value<bool> acceptsInsurance,
});

class $$PharmaciesTableFilterComposer
    extends Composer<_$AppDatabase, $PharmaciesTable> {
  $$PharmaciesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get pharmacyId => $composableBuilder(
      column: $table.pharmacyId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get acceptsInsurance => $composableBuilder(
      column: $table.acceptsInsurance,
      builder: (column) => ColumnFilters(column));
}

class $$PharmaciesTableOrderingComposer
    extends Composer<_$AppDatabase, $PharmaciesTable> {
  $$PharmaciesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get pharmacyId => $composableBuilder(
      column: $table.pharmacyId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get acceptsInsurance => $composableBuilder(
      column: $table.acceptsInsurance,
      builder: (column) => ColumnOrderings(column));
}

class $$PharmaciesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PharmaciesTable> {
  $$PharmaciesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get pharmacyId => $composableBuilder(
      column: $table.pharmacyId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<bool> get acceptsInsurance => $composableBuilder(
      column: $table.acceptsInsurance, builder: (column) => column);
}

class $$PharmaciesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PharmaciesTable,
    Pharmacy,
    $$PharmaciesTableFilterComposer,
    $$PharmaciesTableOrderingComposer,
    $$PharmaciesTableAnnotationComposer,
    $$PharmaciesTableCreateCompanionBuilder,
    $$PharmaciesTableUpdateCompanionBuilder,
    (Pharmacy, BaseReferences<_$AppDatabase, $PharmaciesTable, Pharmacy>),
    Pharmacy,
    PrefetchHooks Function()> {
  $$PharmaciesTableTableManager(_$AppDatabase db, $PharmaciesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PharmaciesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PharmaciesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PharmaciesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> pharmacyId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<double?> latitude = const Value.absent(),
            Value<double?> longitude = const Value.absent(),
            Value<bool> acceptsInsurance = const Value.absent(),
          }) =>
              PharmaciesCompanion(
            pharmacyId: pharmacyId,
            name: name,
            address: address,
            phone: phone,
            latitude: latitude,
            longitude: longitude,
            acceptsInsurance: acceptsInsurance,
          ),
          createCompanionCallback: ({
            Value<int> pharmacyId = const Value.absent(),
            required String name,
            Value<String?> address = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<double?> latitude = const Value.absent(),
            Value<double?> longitude = const Value.absent(),
            Value<bool> acceptsInsurance = const Value.absent(),
          }) =>
              PharmaciesCompanion.insert(
            pharmacyId: pharmacyId,
            name: name,
            address: address,
            phone: phone,
            latitude: latitude,
            longitude: longitude,
            acceptsInsurance: acceptsInsurance,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PharmaciesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PharmaciesTable,
    Pharmacy,
    $$PharmaciesTableFilterComposer,
    $$PharmaciesTableOrderingComposer,
    $$PharmaciesTableAnnotationComposer,
    $$PharmaciesTableCreateCompanionBuilder,
    $$PharmaciesTableUpdateCompanionBuilder,
    (Pharmacy, BaseReferences<_$AppDatabase, $PharmaciesTable, Pharmacy>),
    Pharmacy,
    PrefetchHooks Function()>;
typedef $$MedicationsTableCreateCompanionBuilder = MedicationsCompanion
    Function({
  Value<int> medicationId,
  required String name,
  Value<String?> description,
  Value<bool> controlledSubstance,
});
typedef $$MedicationsTableUpdateCompanionBuilder = MedicationsCompanion
    Function({
  Value<int> medicationId,
  Value<String> name,
  Value<String?> description,
  Value<bool> controlledSubstance,
});

class $$MedicationsTableFilterComposer
    extends Composer<_$AppDatabase, $MedicationsTable> {
  $$MedicationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get medicationId => $composableBuilder(
      column: $table.medicationId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get controlledSubstance => $composableBuilder(
      column: $table.controlledSubstance,
      builder: (column) => ColumnFilters(column));
}

class $$MedicationsTableOrderingComposer
    extends Composer<_$AppDatabase, $MedicationsTable> {
  $$MedicationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get medicationId => $composableBuilder(
      column: $table.medicationId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get controlledSubstance => $composableBuilder(
      column: $table.controlledSubstance,
      builder: (column) => ColumnOrderings(column));
}

class $$MedicationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MedicationsTable> {
  $$MedicationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get medicationId => $composableBuilder(
      column: $table.medicationId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<bool> get controlledSubstance => $composableBuilder(
      column: $table.controlledSubstance, builder: (column) => column);
}

class $$MedicationsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MedicationsTable,
    Medication,
    $$MedicationsTableFilterComposer,
    $$MedicationsTableOrderingComposer,
    $$MedicationsTableAnnotationComposer,
    $$MedicationsTableCreateCompanionBuilder,
    $$MedicationsTableUpdateCompanionBuilder,
    (Medication, BaseReferences<_$AppDatabase, $MedicationsTable, Medication>),
    Medication,
    PrefetchHooks Function()> {
  $$MedicationsTableTableManager(_$AppDatabase db, $MedicationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MedicationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MedicationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MedicationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> medicationId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<bool> controlledSubstance = const Value.absent(),
          }) =>
              MedicationsCompanion(
            medicationId: medicationId,
            name: name,
            description: description,
            controlledSubstance: controlledSubstance,
          ),
          createCompanionCallback: ({
            Value<int> medicationId = const Value.absent(),
            required String name,
            Value<String?> description = const Value.absent(),
            Value<bool> controlledSubstance = const Value.absent(),
          }) =>
              MedicationsCompanion.insert(
            medicationId: medicationId,
            name: name,
            description: description,
            controlledSubstance: controlledSubstance,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MedicationsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MedicationsTable,
    Medication,
    $$MedicationsTableFilterComposer,
    $$MedicationsTableOrderingComposer,
    $$MedicationsTableAnnotationComposer,
    $$MedicationsTableCreateCompanionBuilder,
    $$MedicationsTableUpdateCompanionBuilder,
    (Medication, BaseReferences<_$AppDatabase, $MedicationsTable, Medication>),
    Medication,
    PrefetchHooks Function()>;
typedef $$InventoryTableCreateCompanionBuilder = InventoryCompanion Function({
  Value<int> inventoryId,
  required int pharmacyId,
  required int medicationId,
  Value<int> quantity,
  Value<int> reorderThreshold,
  Value<double> price,
});
typedef $$InventoryTableUpdateCompanionBuilder = InventoryCompanion Function({
  Value<int> inventoryId,
  Value<int> pharmacyId,
  Value<int> medicationId,
  Value<int> quantity,
  Value<int> reorderThreshold,
  Value<double> price,
});

class $$InventoryTableFilterComposer
    extends Composer<_$AppDatabase, $InventoryTable> {
  $$InventoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get inventoryId => $composableBuilder(
      column: $table.inventoryId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get pharmacyId => $composableBuilder(
      column: $table.pharmacyId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get medicationId => $composableBuilder(
      column: $table.medicationId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get reorderThreshold => $composableBuilder(
      column: $table.reorderThreshold,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnFilters(column));
}

class $$InventoryTableOrderingComposer
    extends Composer<_$AppDatabase, $InventoryTable> {
  $$InventoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get inventoryId => $composableBuilder(
      column: $table.inventoryId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get pharmacyId => $composableBuilder(
      column: $table.pharmacyId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get medicationId => $composableBuilder(
      column: $table.medicationId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get reorderThreshold => $composableBuilder(
      column: $table.reorderThreshold,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnOrderings(column));
}

class $$InventoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $InventoryTable> {
  $$InventoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get inventoryId => $composableBuilder(
      column: $table.inventoryId, builder: (column) => column);

  GeneratedColumn<int> get pharmacyId => $composableBuilder(
      column: $table.pharmacyId, builder: (column) => column);

  GeneratedColumn<int> get medicationId => $composableBuilder(
      column: $table.medicationId, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<int> get reorderThreshold => $composableBuilder(
      column: $table.reorderThreshold, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);
}

class $$InventoryTableTableManager extends RootTableManager<
    _$AppDatabase,
    $InventoryTable,
    InventoryData,
    $$InventoryTableFilterComposer,
    $$InventoryTableOrderingComposer,
    $$InventoryTableAnnotationComposer,
    $$InventoryTableCreateCompanionBuilder,
    $$InventoryTableUpdateCompanionBuilder,
    (
      InventoryData,
      BaseReferences<_$AppDatabase, $InventoryTable, InventoryData>
    ),
    InventoryData,
    PrefetchHooks Function()> {
  $$InventoryTableTableManager(_$AppDatabase db, $InventoryTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InventoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InventoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InventoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> inventoryId = const Value.absent(),
            Value<int> pharmacyId = const Value.absent(),
            Value<int> medicationId = const Value.absent(),
            Value<int> quantity = const Value.absent(),
            Value<int> reorderThreshold = const Value.absent(),
            Value<double> price = const Value.absent(),
          }) =>
              InventoryCompanion(
            inventoryId: inventoryId,
            pharmacyId: pharmacyId,
            medicationId: medicationId,
            quantity: quantity,
            reorderThreshold: reorderThreshold,
            price: price,
          ),
          createCompanionCallback: ({
            Value<int> inventoryId = const Value.absent(),
            required int pharmacyId,
            required int medicationId,
            Value<int> quantity = const Value.absent(),
            Value<int> reorderThreshold = const Value.absent(),
            Value<double> price = const Value.absent(),
          }) =>
              InventoryCompanion.insert(
            inventoryId: inventoryId,
            pharmacyId: pharmacyId,
            medicationId: medicationId,
            quantity: quantity,
            reorderThreshold: reorderThreshold,
            price: price,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$InventoryTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $InventoryTable,
    InventoryData,
    $$InventoryTableFilterComposer,
    $$InventoryTableOrderingComposer,
    $$InventoryTableAnnotationComposer,
    $$InventoryTableCreateCompanionBuilder,
    $$InventoryTableUpdateCompanionBuilder,
    (
      InventoryData,
      BaseReferences<_$AppDatabase, $InventoryTable, InventoryData>
    ),
    InventoryData,
    PrefetchHooks Function()>;
typedef $$PrescriptionsTableCreateCompanionBuilder = PrescriptionsCompanion
    Function({
  Value<int> prescriptionId,
  required int patientId,
  required int physicianId,
  Value<DateTime> createdAt,
  Value<String> status,
  Value<String?> instructions,
});
typedef $$PrescriptionsTableUpdateCompanionBuilder = PrescriptionsCompanion
    Function({
  Value<int> prescriptionId,
  Value<int> patientId,
  Value<int> physicianId,
  Value<DateTime> createdAt,
  Value<String> status,
  Value<String?> instructions,
});

class $$PrescriptionsTableFilterComposer
    extends Composer<_$AppDatabase, $PrescriptionsTable> {
  $$PrescriptionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get prescriptionId => $composableBuilder(
      column: $table.prescriptionId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get patientId => $composableBuilder(
      column: $table.patientId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get physicianId => $composableBuilder(
      column: $table.physicianId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get instructions => $composableBuilder(
      column: $table.instructions, builder: (column) => ColumnFilters(column));
}

class $$PrescriptionsTableOrderingComposer
    extends Composer<_$AppDatabase, $PrescriptionsTable> {
  $$PrescriptionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get prescriptionId => $composableBuilder(
      column: $table.prescriptionId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get patientId => $composableBuilder(
      column: $table.patientId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get physicianId => $composableBuilder(
      column: $table.physicianId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get instructions => $composableBuilder(
      column: $table.instructions,
      builder: (column) => ColumnOrderings(column));
}

class $$PrescriptionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PrescriptionsTable> {
  $$PrescriptionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get prescriptionId => $composableBuilder(
      column: $table.prescriptionId, builder: (column) => column);

  GeneratedColumn<int> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<int> get physicianId => $composableBuilder(
      column: $table.physicianId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get instructions => $composableBuilder(
      column: $table.instructions, builder: (column) => column);
}

class $$PrescriptionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PrescriptionsTable,
    Prescription,
    $$PrescriptionsTableFilterComposer,
    $$PrescriptionsTableOrderingComposer,
    $$PrescriptionsTableAnnotationComposer,
    $$PrescriptionsTableCreateCompanionBuilder,
    $$PrescriptionsTableUpdateCompanionBuilder,
    (
      Prescription,
      BaseReferences<_$AppDatabase, $PrescriptionsTable, Prescription>
    ),
    Prescription,
    PrefetchHooks Function()> {
  $$PrescriptionsTableTableManager(_$AppDatabase db, $PrescriptionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PrescriptionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PrescriptionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PrescriptionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> prescriptionId = const Value.absent(),
            Value<int> patientId = const Value.absent(),
            Value<int> physicianId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> instructions = const Value.absent(),
          }) =>
              PrescriptionsCompanion(
            prescriptionId: prescriptionId,
            patientId: patientId,
            physicianId: physicianId,
            createdAt: createdAt,
            status: status,
            instructions: instructions,
          ),
          createCompanionCallback: ({
            Value<int> prescriptionId = const Value.absent(),
            required int patientId,
            required int physicianId,
            Value<DateTime> createdAt = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> instructions = const Value.absent(),
          }) =>
              PrescriptionsCompanion.insert(
            prescriptionId: prescriptionId,
            patientId: patientId,
            physicianId: physicianId,
            createdAt: createdAt,
            status: status,
            instructions: instructions,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PrescriptionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PrescriptionsTable,
    Prescription,
    $$PrescriptionsTableFilterComposer,
    $$PrescriptionsTableOrderingComposer,
    $$PrescriptionsTableAnnotationComposer,
    $$PrescriptionsTableCreateCompanionBuilder,
    $$PrescriptionsTableUpdateCompanionBuilder,
    (
      Prescription,
      BaseReferences<_$AppDatabase, $PrescriptionsTable, Prescription>
    ),
    Prescription,
    PrefetchHooks Function()>;
typedef $$PrescriptionItemsTableCreateCompanionBuilder
    = PrescriptionItemsCompanion Function({
  Value<int> itemId,
  required int prescriptionId,
  required int medicationId,
  Value<String?> dosage,
  Value<String?> frequency,
  Value<int> quantity,
});
typedef $$PrescriptionItemsTableUpdateCompanionBuilder
    = PrescriptionItemsCompanion Function({
  Value<int> itemId,
  Value<int> prescriptionId,
  Value<int> medicationId,
  Value<String?> dosage,
  Value<String?> frequency,
  Value<int> quantity,
});

class $$PrescriptionItemsTableFilterComposer
    extends Composer<_$AppDatabase, $PrescriptionItemsTable> {
  $$PrescriptionItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get itemId => $composableBuilder(
      column: $table.itemId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get prescriptionId => $composableBuilder(
      column: $table.prescriptionId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get medicationId => $composableBuilder(
      column: $table.medicationId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dosage => $composableBuilder(
      column: $table.dosage, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get frequency => $composableBuilder(
      column: $table.frequency, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnFilters(column));
}

class $$PrescriptionItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $PrescriptionItemsTable> {
  $$PrescriptionItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get itemId => $composableBuilder(
      column: $table.itemId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get prescriptionId => $composableBuilder(
      column: $table.prescriptionId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get medicationId => $composableBuilder(
      column: $table.medicationId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dosage => $composableBuilder(
      column: $table.dosage, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get frequency => $composableBuilder(
      column: $table.frequency, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnOrderings(column));
}

class $$PrescriptionItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PrescriptionItemsTable> {
  $$PrescriptionItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  GeneratedColumn<int> get prescriptionId => $composableBuilder(
      column: $table.prescriptionId, builder: (column) => column);

  GeneratedColumn<int> get medicationId => $composableBuilder(
      column: $table.medicationId, builder: (column) => column);

  GeneratedColumn<String> get dosage =>
      $composableBuilder(column: $table.dosage, builder: (column) => column);

  GeneratedColumn<String> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);
}

class $$PrescriptionItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PrescriptionItemsTable,
    PrescriptionItem,
    $$PrescriptionItemsTableFilterComposer,
    $$PrescriptionItemsTableOrderingComposer,
    $$PrescriptionItemsTableAnnotationComposer,
    $$PrescriptionItemsTableCreateCompanionBuilder,
    $$PrescriptionItemsTableUpdateCompanionBuilder,
    (
      PrescriptionItem,
      BaseReferences<_$AppDatabase, $PrescriptionItemsTable, PrescriptionItem>
    ),
    PrescriptionItem,
    PrefetchHooks Function()> {
  $$PrescriptionItemsTableTableManager(
      _$AppDatabase db, $PrescriptionItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PrescriptionItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PrescriptionItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PrescriptionItemsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> itemId = const Value.absent(),
            Value<int> prescriptionId = const Value.absent(),
            Value<int> medicationId = const Value.absent(),
            Value<String?> dosage = const Value.absent(),
            Value<String?> frequency = const Value.absent(),
            Value<int> quantity = const Value.absent(),
          }) =>
              PrescriptionItemsCompanion(
            itemId: itemId,
            prescriptionId: prescriptionId,
            medicationId: medicationId,
            dosage: dosage,
            frequency: frequency,
            quantity: quantity,
          ),
          createCompanionCallback: ({
            Value<int> itemId = const Value.absent(),
            required int prescriptionId,
            required int medicationId,
            Value<String?> dosage = const Value.absent(),
            Value<String?> frequency = const Value.absent(),
            Value<int> quantity = const Value.absent(),
          }) =>
              PrescriptionItemsCompanion.insert(
            itemId: itemId,
            prescriptionId: prescriptionId,
            medicationId: medicationId,
            dosage: dosage,
            frequency: frequency,
            quantity: quantity,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PrescriptionItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PrescriptionItemsTable,
    PrescriptionItem,
    $$PrescriptionItemsTableFilterComposer,
    $$PrescriptionItemsTableOrderingComposer,
    $$PrescriptionItemsTableAnnotationComposer,
    $$PrescriptionItemsTableCreateCompanionBuilder,
    $$PrescriptionItemsTableUpdateCompanionBuilder,
    (
      PrescriptionItem,
      BaseReferences<_$AppDatabase, $PrescriptionItemsTable, PrescriptionItem>
    ),
    PrescriptionItem,
    PrefetchHooks Function()>;
typedef $$FeedbacksTableCreateCompanionBuilder = FeedbacksCompanion Function({
  Value<int> id,
  required int userId,
  required String message,
  Value<DateTime> createdAt,
});
typedef $$FeedbacksTableUpdateCompanionBuilder = FeedbacksCompanion Function({
  Value<int> id,
  Value<int> userId,
  Value<String> message,
  Value<DateTime> createdAt,
});

class $$FeedbacksTableFilterComposer
    extends Composer<_$AppDatabase, $FeedbacksTable> {
  $$FeedbacksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get message => $composableBuilder(
      column: $table.message, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$FeedbacksTableOrderingComposer
    extends Composer<_$AppDatabase, $FeedbacksTable> {
  $$FeedbacksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get message => $composableBuilder(
      column: $table.message, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$FeedbacksTableAnnotationComposer
    extends Composer<_$AppDatabase, $FeedbacksTable> {
  $$FeedbacksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$FeedbacksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FeedbacksTable,
    Feedback,
    $$FeedbacksTableFilterComposer,
    $$FeedbacksTableOrderingComposer,
    $$FeedbacksTableAnnotationComposer,
    $$FeedbacksTableCreateCompanionBuilder,
    $$FeedbacksTableUpdateCompanionBuilder,
    (Feedback, BaseReferences<_$AppDatabase, $FeedbacksTable, Feedback>),
    Feedback,
    PrefetchHooks Function()> {
  $$FeedbacksTableTableManager(_$AppDatabase db, $FeedbacksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeedbacksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FeedbacksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FeedbacksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> userId = const Value.absent(),
            Value<String> message = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              FeedbacksCompanion(
            id: id,
            userId: userId,
            message: message,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int userId,
            required String message,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              FeedbacksCompanion.insert(
            id: id,
            userId: userId,
            message: message,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FeedbacksTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FeedbacksTable,
    Feedback,
    $$FeedbacksTableFilterComposer,
    $$FeedbacksTableOrderingComposer,
    $$FeedbacksTableAnnotationComposer,
    $$FeedbacksTableCreateCompanionBuilder,
    $$FeedbacksTableUpdateCompanionBuilder,
    (Feedback, BaseReferences<_$AppDatabase, $FeedbacksTable, Feedback>),
    Feedback,
    PrefetchHooks Function()>;
typedef $$AuditLogsTableCreateCompanionBuilder = AuditLogsCompanion Function({
  Value<int> id,
  required int userId,
  required String action,
  Value<String?> details,
  Value<DateTime> createdAt,
});
typedef $$AuditLogsTableUpdateCompanionBuilder = AuditLogsCompanion Function({
  Value<int> id,
  Value<int> userId,
  Value<String> action,
  Value<String?> details,
  Value<DateTime> createdAt,
});

class $$AuditLogsTableFilterComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get action => $composableBuilder(
      column: $table.action, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get details => $composableBuilder(
      column: $table.details, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$AuditLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get action => $composableBuilder(
      column: $table.action, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get details => $composableBuilder(
      column: $table.details, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$AuditLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<String> get details =>
      $composableBuilder(column: $table.details, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$AuditLogsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AuditLogsTable,
    AuditLog,
    $$AuditLogsTableFilterComposer,
    $$AuditLogsTableOrderingComposer,
    $$AuditLogsTableAnnotationComposer,
    $$AuditLogsTableCreateCompanionBuilder,
    $$AuditLogsTableUpdateCompanionBuilder,
    (AuditLog, BaseReferences<_$AppDatabase, $AuditLogsTable, AuditLog>),
    AuditLog,
    PrefetchHooks Function()> {
  $$AuditLogsTableTableManager(_$AppDatabase db, $AuditLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AuditLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AuditLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AuditLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> userId = const Value.absent(),
            Value<String> action = const Value.absent(),
            Value<String?> details = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              AuditLogsCompanion(
            id: id,
            userId: userId,
            action: action,
            details: details,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int userId,
            required String action,
            Value<String?> details = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              AuditLogsCompanion.insert(
            id: id,
            userId: userId,
            action: action,
            details: details,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AuditLogsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AuditLogsTable,
    AuditLog,
    $$AuditLogsTableFilterComposer,
    $$AuditLogsTableOrderingComposer,
    $$AuditLogsTableAnnotationComposer,
    $$AuditLogsTableCreateCompanionBuilder,
    $$AuditLogsTableUpdateCompanionBuilder,
    (AuditLog, BaseReferences<_$AppDatabase, $AuditLogsTable, AuditLog>),
    AuditLog,
    PrefetchHooks Function()>;
typedef $$EmergencyAccessRequestsTableCreateCompanionBuilder
    = EmergencyAccessRequestsCompanion Function({
  Value<int> id,
  required int patientId,
  required int physicianId,
  required String reason,
  Value<String> status,
  Value<DateTime> createdAt,
});
typedef $$EmergencyAccessRequestsTableUpdateCompanionBuilder
    = EmergencyAccessRequestsCompanion Function({
  Value<int> id,
  Value<int> patientId,
  Value<int> physicianId,
  Value<String> reason,
  Value<String> status,
  Value<DateTime> createdAt,
});

class $$EmergencyAccessRequestsTableFilterComposer
    extends Composer<_$AppDatabase, $EmergencyAccessRequestsTable> {
  $$EmergencyAccessRequestsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get patientId => $composableBuilder(
      column: $table.patientId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get physicianId => $composableBuilder(
      column: $table.physicianId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reason => $composableBuilder(
      column: $table.reason, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$EmergencyAccessRequestsTableOrderingComposer
    extends Composer<_$AppDatabase, $EmergencyAccessRequestsTable> {
  $$EmergencyAccessRequestsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get patientId => $composableBuilder(
      column: $table.patientId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get physicianId => $composableBuilder(
      column: $table.physicianId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reason => $composableBuilder(
      column: $table.reason, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$EmergencyAccessRequestsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EmergencyAccessRequestsTable> {
  $$EmergencyAccessRequestsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<int> get physicianId => $composableBuilder(
      column: $table.physicianId, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$EmergencyAccessRequestsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EmergencyAccessRequestsTable,
    EmergencyAccessRequest,
    $$EmergencyAccessRequestsTableFilterComposer,
    $$EmergencyAccessRequestsTableOrderingComposer,
    $$EmergencyAccessRequestsTableAnnotationComposer,
    $$EmergencyAccessRequestsTableCreateCompanionBuilder,
    $$EmergencyAccessRequestsTableUpdateCompanionBuilder,
    (
      EmergencyAccessRequest,
      BaseReferences<_$AppDatabase, $EmergencyAccessRequestsTable,
          EmergencyAccessRequest>
    ),
    EmergencyAccessRequest,
    PrefetchHooks Function()> {
  $$EmergencyAccessRequestsTableTableManager(
      _$AppDatabase db, $EmergencyAccessRequestsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EmergencyAccessRequestsTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$EmergencyAccessRequestsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EmergencyAccessRequestsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> patientId = const Value.absent(),
            Value<int> physicianId = const Value.absent(),
            Value<String> reason = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              EmergencyAccessRequestsCompanion(
            id: id,
            patientId: patientId,
            physicianId: physicianId,
            reason: reason,
            status: status,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int patientId,
            required int physicianId,
            required String reason,
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              EmergencyAccessRequestsCompanion.insert(
            id: id,
            patientId: patientId,
            physicianId: physicianId,
            reason: reason,
            status: status,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$EmergencyAccessRequestsTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $EmergencyAccessRequestsTable,
        EmergencyAccessRequest,
        $$EmergencyAccessRequestsTableFilterComposer,
        $$EmergencyAccessRequestsTableOrderingComposer,
        $$EmergencyAccessRequestsTableAnnotationComposer,
        $$EmergencyAccessRequestsTableCreateCompanionBuilder,
        $$EmergencyAccessRequestsTableUpdateCompanionBuilder,
        (
          EmergencyAccessRequest,
          BaseReferences<_$AppDatabase, $EmergencyAccessRequestsTable,
              EmergencyAccessRequest>
        ),
        EmergencyAccessRequest,
        PrefetchHooks Function()>;
typedef $$InsurancesTableCreateCompanionBuilder = InsurancesCompanion Function({
  Value<int> id,
  required String name,
  required String details,
});
typedef $$InsurancesTableUpdateCompanionBuilder = InsurancesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> details,
});

class $$InsurancesTableFilterComposer
    extends Composer<_$AppDatabase, $InsurancesTable> {
  $$InsurancesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get details => $composableBuilder(
      column: $table.details, builder: (column) => ColumnFilters(column));
}

class $$InsurancesTableOrderingComposer
    extends Composer<_$AppDatabase, $InsurancesTable> {
  $$InsurancesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get details => $composableBuilder(
      column: $table.details, builder: (column) => ColumnOrderings(column));
}

class $$InsurancesTableAnnotationComposer
    extends Composer<_$AppDatabase, $InsurancesTable> {
  $$InsurancesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get details =>
      $composableBuilder(column: $table.details, builder: (column) => column);
}

class $$InsurancesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $InsurancesTable,
    Insurance,
    $$InsurancesTableFilterComposer,
    $$InsurancesTableOrderingComposer,
    $$InsurancesTableAnnotationComposer,
    $$InsurancesTableCreateCompanionBuilder,
    $$InsurancesTableUpdateCompanionBuilder,
    (Insurance, BaseReferences<_$AppDatabase, $InsurancesTable, Insurance>),
    Insurance,
    PrefetchHooks Function()> {
  $$InsurancesTableTableManager(_$AppDatabase db, $InsurancesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InsurancesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InsurancesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InsurancesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> details = const Value.absent(),
          }) =>
              InsurancesCompanion(
            id: id,
            name: name,
            details: details,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String details,
          }) =>
              InsurancesCompanion.insert(
            id: id,
            name: name,
            details: details,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$InsurancesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $InsurancesTable,
    Insurance,
    $$InsurancesTableFilterComposer,
    $$InsurancesTableOrderingComposer,
    $$InsurancesTableAnnotationComposer,
    $$InsurancesTableCreateCompanionBuilder,
    $$InsurancesTableUpdateCompanionBuilder,
    (Insurance, BaseReferences<_$AppDatabase, $InsurancesTable, Insurance>),
    Insurance,
    PrefetchHooks Function()>;
typedef $$PharmacyInsurancesTableCreateCompanionBuilder
    = PharmacyInsurancesCompanion Function({
  Value<int> id,
  required int pharmacyId,
  required int insuranceId,
});
typedef $$PharmacyInsurancesTableUpdateCompanionBuilder
    = PharmacyInsurancesCompanion Function({
  Value<int> id,
  Value<int> pharmacyId,
  Value<int> insuranceId,
});

class $$PharmacyInsurancesTableFilterComposer
    extends Composer<_$AppDatabase, $PharmacyInsurancesTable> {
  $$PharmacyInsurancesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get pharmacyId => $composableBuilder(
      column: $table.pharmacyId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get insuranceId => $composableBuilder(
      column: $table.insuranceId, builder: (column) => ColumnFilters(column));
}

class $$PharmacyInsurancesTableOrderingComposer
    extends Composer<_$AppDatabase, $PharmacyInsurancesTable> {
  $$PharmacyInsurancesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get pharmacyId => $composableBuilder(
      column: $table.pharmacyId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get insuranceId => $composableBuilder(
      column: $table.insuranceId, builder: (column) => ColumnOrderings(column));
}

class $$PharmacyInsurancesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PharmacyInsurancesTable> {
  $$PharmacyInsurancesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get pharmacyId => $composableBuilder(
      column: $table.pharmacyId, builder: (column) => column);

  GeneratedColumn<int> get insuranceId => $composableBuilder(
      column: $table.insuranceId, builder: (column) => column);
}

class $$PharmacyInsurancesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PharmacyInsurancesTable,
    PharmacyInsurance,
    $$PharmacyInsurancesTableFilterComposer,
    $$PharmacyInsurancesTableOrderingComposer,
    $$PharmacyInsurancesTableAnnotationComposer,
    $$PharmacyInsurancesTableCreateCompanionBuilder,
    $$PharmacyInsurancesTableUpdateCompanionBuilder,
    (
      PharmacyInsurance,
      BaseReferences<_$AppDatabase, $PharmacyInsurancesTable, PharmacyInsurance>
    ),
    PharmacyInsurance,
    PrefetchHooks Function()> {
  $$PharmacyInsurancesTableTableManager(
      _$AppDatabase db, $PharmacyInsurancesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PharmacyInsurancesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PharmacyInsurancesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PharmacyInsurancesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> pharmacyId = const Value.absent(),
            Value<int> insuranceId = const Value.absent(),
          }) =>
              PharmacyInsurancesCompanion(
            id: id,
            pharmacyId: pharmacyId,
            insuranceId: insuranceId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int pharmacyId,
            required int insuranceId,
          }) =>
              PharmacyInsurancesCompanion.insert(
            id: id,
            pharmacyId: pharmacyId,
            insuranceId: insuranceId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PharmacyInsurancesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PharmacyInsurancesTable,
    PharmacyInsurance,
    $$PharmacyInsurancesTableFilterComposer,
    $$PharmacyInsurancesTableOrderingComposer,
    $$PharmacyInsurancesTableAnnotationComposer,
    $$PharmacyInsurancesTableCreateCompanionBuilder,
    $$PharmacyInsurancesTableUpdateCompanionBuilder,
    (
      PharmacyInsurance,
      BaseReferences<_$AppDatabase, $PharmacyInsurancesTable, PharmacyInsurance>
    ),
    PharmacyInsurance,
    PrefetchHooks Function()>;
typedef $$BlockchainTransactionsTableCreateCompanionBuilder
    = BlockchainTransactionsCompanion Function({
  Value<int> id,
  required int prescriptionId,
  required String transactionHash,
  Value<DateTime> createdAt,
});
typedef $$BlockchainTransactionsTableUpdateCompanionBuilder
    = BlockchainTransactionsCompanion Function({
  Value<int> id,
  Value<int> prescriptionId,
  Value<String> transactionHash,
  Value<DateTime> createdAt,
});

class $$BlockchainTransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $BlockchainTransactionsTable> {
  $$BlockchainTransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get prescriptionId => $composableBuilder(
      column: $table.prescriptionId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get transactionHash => $composableBuilder(
      column: $table.transactionHash,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$BlockchainTransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $BlockchainTransactionsTable> {
  $$BlockchainTransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get prescriptionId => $composableBuilder(
      column: $table.prescriptionId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get transactionHash => $composableBuilder(
      column: $table.transactionHash,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$BlockchainTransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BlockchainTransactionsTable> {
  $$BlockchainTransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get prescriptionId => $composableBuilder(
      column: $table.prescriptionId, builder: (column) => column);

  GeneratedColumn<String> get transactionHash => $composableBuilder(
      column: $table.transactionHash, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$BlockchainTransactionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BlockchainTransactionsTable,
    BlockchainTransaction,
    $$BlockchainTransactionsTableFilterComposer,
    $$BlockchainTransactionsTableOrderingComposer,
    $$BlockchainTransactionsTableAnnotationComposer,
    $$BlockchainTransactionsTableCreateCompanionBuilder,
    $$BlockchainTransactionsTableUpdateCompanionBuilder,
    (
      BlockchainTransaction,
      BaseReferences<_$AppDatabase, $BlockchainTransactionsTable,
          BlockchainTransaction>
    ),
    BlockchainTransaction,
    PrefetchHooks Function()> {
  $$BlockchainTransactionsTableTableManager(
      _$AppDatabase db, $BlockchainTransactionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BlockchainTransactionsTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$BlockchainTransactionsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BlockchainTransactionsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> prescriptionId = const Value.absent(),
            Value<String> transactionHash = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              BlockchainTransactionsCompanion(
            id: id,
            prescriptionId: prescriptionId,
            transactionHash: transactionHash,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int prescriptionId,
            required String transactionHash,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              BlockchainTransactionsCompanion.insert(
            id: id,
            prescriptionId: prescriptionId,
            transactionHash: transactionHash,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$BlockchainTransactionsTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $BlockchainTransactionsTable,
        BlockchainTransaction,
        $$BlockchainTransactionsTableFilterComposer,
        $$BlockchainTransactionsTableOrderingComposer,
        $$BlockchainTransactionsTableAnnotationComposer,
        $$BlockchainTransactionsTableCreateCompanionBuilder,
        $$BlockchainTransactionsTableUpdateCompanionBuilder,
        (
          BlockchainTransaction,
          BaseReferences<_$AppDatabase, $BlockchainTransactionsTable,
              BlockchainTransaction>
        ),
        BlockchainTransaction,
        PrefetchHooks Function()>;
typedef $$PharmacistTableCreateCompanionBuilder = PharmacistCompanion Function({
  Value<int> id,
  required int pharmacyId,
  required int pharmacistId,
});
typedef $$PharmacistTableUpdateCompanionBuilder = PharmacistCompanion Function({
  Value<int> id,
  Value<int> pharmacyId,
  Value<int> pharmacistId,
});

class $$PharmacistTableFilterComposer
    extends Composer<_$AppDatabase, $PharmacistTable> {
  $$PharmacistTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get pharmacyId => $composableBuilder(
      column: $table.pharmacyId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get pharmacistId => $composableBuilder(
      column: $table.pharmacistId, builder: (column) => ColumnFilters(column));
}

class $$PharmacistTableOrderingComposer
    extends Composer<_$AppDatabase, $PharmacistTable> {
  $$PharmacistTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get pharmacyId => $composableBuilder(
      column: $table.pharmacyId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get pharmacistId => $composableBuilder(
      column: $table.pharmacistId,
      builder: (column) => ColumnOrderings(column));
}

class $$PharmacistTableAnnotationComposer
    extends Composer<_$AppDatabase, $PharmacistTable> {
  $$PharmacistTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get pharmacyId => $composableBuilder(
      column: $table.pharmacyId, builder: (column) => column);

  GeneratedColumn<int> get pharmacistId => $composableBuilder(
      column: $table.pharmacistId, builder: (column) => column);
}

class $$PharmacistTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PharmacistTable,
    PharmacistData,
    $$PharmacistTableFilterComposer,
    $$PharmacistTableOrderingComposer,
    $$PharmacistTableAnnotationComposer,
    $$PharmacistTableCreateCompanionBuilder,
    $$PharmacistTableUpdateCompanionBuilder,
    (
      PharmacistData,
      BaseReferences<_$AppDatabase, $PharmacistTable, PharmacistData>
    ),
    PharmacistData,
    PrefetchHooks Function()> {
  $$PharmacistTableTableManager(_$AppDatabase db, $PharmacistTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PharmacistTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PharmacistTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PharmacistTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> pharmacyId = const Value.absent(),
            Value<int> pharmacistId = const Value.absent(),
          }) =>
              PharmacistCompanion(
            id: id,
            pharmacyId: pharmacyId,
            pharmacistId: pharmacistId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int pharmacyId,
            required int pharmacistId,
          }) =>
              PharmacistCompanion.insert(
            id: id,
            pharmacyId: pharmacyId,
            pharmacistId: pharmacistId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PharmacistTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PharmacistTable,
    PharmacistData,
    $$PharmacistTableFilterComposer,
    $$PharmacistTableOrderingComposer,
    $$PharmacistTableAnnotationComposer,
    $$PharmacistTableCreateCompanionBuilder,
    $$PharmacistTableUpdateCompanionBuilder,
    (
      PharmacistData,
      BaseReferences<_$AppDatabase, $PharmacistTable, PharmacistData>
    ),
    PharmacistData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$PharmaciesTableTableManager get pharmacies =>
      $$PharmaciesTableTableManager(_db, _db.pharmacies);
  $$MedicationsTableTableManager get medications =>
      $$MedicationsTableTableManager(_db, _db.medications);
  $$InventoryTableTableManager get inventory =>
      $$InventoryTableTableManager(_db, _db.inventory);
  $$PrescriptionsTableTableManager get prescriptions =>
      $$PrescriptionsTableTableManager(_db, _db.prescriptions);
  $$PrescriptionItemsTableTableManager get prescriptionItems =>
      $$PrescriptionItemsTableTableManager(_db, _db.prescriptionItems);
  $$FeedbacksTableTableManager get feedbacks =>
      $$FeedbacksTableTableManager(_db, _db.feedbacks);
  $$AuditLogsTableTableManager get auditLogs =>
      $$AuditLogsTableTableManager(_db, _db.auditLogs);
  $$EmergencyAccessRequestsTableTableManager get emergencyAccessRequests =>
      $$EmergencyAccessRequestsTableTableManager(
          _db, _db.emergencyAccessRequests);
  $$InsurancesTableTableManager get insurances =>
      $$InsurancesTableTableManager(_db, _db.insurances);
  $$PharmacyInsurancesTableTableManager get pharmacyInsurances =>
      $$PharmacyInsurancesTableTableManager(_db, _db.pharmacyInsurances);
  $$BlockchainTransactionsTableTableManager get blockchainTransactions =>
      $$BlockchainTransactionsTableTableManager(
          _db, _db.blockchainTransactions);
  $$PharmacistTableTableManager get pharmacist =>
      $$PharmacistTableTableManager(_db, _db.pharmacist);
}
