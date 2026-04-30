// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsersTableTable extends UsersTable
    with TableInfo<$UsersTableTable, UsersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<WeightUnit, String>
  preferredWeightUnit = GeneratedColumn<String>(
    'preferred_weight_unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<WeightUnit>($UsersTableTable.$converterpreferredWeightUnit);
  @override
  late final GeneratedColumnWithTypeConverter<BodyMetricUnit, String>
  preferredBodyMetricUnit =
      GeneratedColumn<String>(
        'preferred_body_metric_unit',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<BodyMetricUnit>(
        $UsersTableTable.$converterpreferredBodyMetricUnit,
      );
  static const VerificationMeta _originalHeightValueMeta =
      const VerificationMeta('originalHeightValue');
  @override
  late final GeneratedColumn<double> originalHeightValue =
      GeneratedColumn<double>(
        'original_height_value',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  @override
  late final GeneratedColumnWithTypeConverter<BodyMetricUnit?, String>
  originalHeightUnit =
      GeneratedColumn<String>(
        'original_height_unit',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<BodyMetricUnit?>(
        $UsersTableTable.$converteroriginalHeightUnitn,
      );
  static const VerificationMeta _canonicalHeightCentimetersMeta =
      const VerificationMeta('canonicalHeightCentimeters');
  @override
  late final GeneratedColumn<double> canonicalHeightCentimeters =
      GeneratedColumn<double>(
        'canonical_height_centimeters',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  @override
  late final GeneratedColumnWithTypeConverter<ActivityLevel?, String>
  activityLevel = GeneratedColumn<String>(
    'activity_level',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<ActivityLevel?>($UsersTableTable.$converteractivityLeveln);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    displayName,
    preferredWeightUnit,
    preferredBodyMetricUnit,
    originalHeightValue,
    originalHeightUnit,
    canonicalHeightCentimeters,
    activityLevel,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<UsersTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('original_height_value')) {
      context.handle(
        _originalHeightValueMeta,
        originalHeightValue.isAcceptableOrUnknown(
          data['original_height_value']!,
          _originalHeightValueMeta,
        ),
      );
    }
    if (data.containsKey('canonical_height_centimeters')) {
      context.handle(
        _canonicalHeightCentimetersMeta,
        canonicalHeightCentimeters.isAcceptableOrUnknown(
          data['canonical_height_centimeters']!,
          _canonicalHeightCentimetersMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UsersTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UsersTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      preferredWeightUnit: $UsersTableTable.$converterpreferredWeightUnit
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}preferred_weight_unit'],
            )!,
          ),
      preferredBodyMetricUnit: $UsersTableTable
          .$converterpreferredBodyMetricUnit
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}preferred_body_metric_unit'],
            )!,
          ),
      originalHeightValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}original_height_value'],
      ),
      originalHeightUnit: $UsersTableTable.$converteroriginalHeightUnitn
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}original_height_unit'],
            ),
          ),
      canonicalHeightCentimeters: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}canonical_height_centimeters'],
      ),
      activityLevel: $UsersTableTable.$converteractivityLeveln.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}activity_level'],
        ),
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UsersTableTable createAlias(String alias) {
    return $UsersTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<WeightUnit, String, String>
  $converterpreferredWeightUnit = const EnumNameConverter<WeightUnit>(
    WeightUnit.values,
  );
  static JsonTypeConverter2<BodyMetricUnit, String, String>
  $converterpreferredBodyMetricUnit = const EnumNameConverter<BodyMetricUnit>(
    BodyMetricUnit.values,
  );
  static JsonTypeConverter2<BodyMetricUnit, String, String>
  $converteroriginalHeightUnit = const EnumNameConverter<BodyMetricUnit>(
    BodyMetricUnit.values,
  );
  static JsonTypeConverter2<BodyMetricUnit?, String?, String?>
  $converteroriginalHeightUnitn = JsonTypeConverter2.asNullable(
    $converteroriginalHeightUnit,
  );
  static JsonTypeConverter2<ActivityLevel, String, String>
  $converteractivityLevel = const EnumNameConverter<ActivityLevel>(
    ActivityLevel.values,
  );
  static JsonTypeConverter2<ActivityLevel?, String?, String?>
  $converteractivityLeveln = JsonTypeConverter2.asNullable(
    $converteractivityLevel,
  );
}

class UsersTableData extends DataClass implements Insertable<UsersTableData> {
  final String id;
  final String displayName;
  final WeightUnit preferredWeightUnit;
  final BodyMetricUnit preferredBodyMetricUnit;
  final double? originalHeightValue;
  final BodyMetricUnit? originalHeightUnit;
  final double? canonicalHeightCentimeters;
  final ActivityLevel? activityLevel;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UsersTableData({
    required this.id,
    required this.displayName,
    required this.preferredWeightUnit,
    required this.preferredBodyMetricUnit,
    this.originalHeightValue,
    this.originalHeightUnit,
    this.canonicalHeightCentimeters,
    this.activityLevel,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['display_name'] = Variable<String>(displayName);
    {
      map['preferred_weight_unit'] = Variable<String>(
        $UsersTableTable.$converterpreferredWeightUnit.toSql(
          preferredWeightUnit,
        ),
      );
    }
    {
      map['preferred_body_metric_unit'] = Variable<String>(
        $UsersTableTable.$converterpreferredBodyMetricUnit.toSql(
          preferredBodyMetricUnit,
        ),
      );
    }
    if (!nullToAbsent || originalHeightValue != null) {
      map['original_height_value'] = Variable<double>(originalHeightValue);
    }
    if (!nullToAbsent || originalHeightUnit != null) {
      map['original_height_unit'] = Variable<String>(
        $UsersTableTable.$converteroriginalHeightUnitn.toSql(
          originalHeightUnit,
        ),
      );
    }
    if (!nullToAbsent || canonicalHeightCentimeters != null) {
      map['canonical_height_centimeters'] = Variable<double>(
        canonicalHeightCentimeters,
      );
    }
    if (!nullToAbsent || activityLevel != null) {
      map['activity_level'] = Variable<String>(
        $UsersTableTable.$converteractivityLeveln.toSql(activityLevel),
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UsersTableCompanion toCompanion(bool nullToAbsent) {
    return UsersTableCompanion(
      id: Value(id),
      displayName: Value(displayName),
      preferredWeightUnit: Value(preferredWeightUnit),
      preferredBodyMetricUnit: Value(preferredBodyMetricUnit),
      originalHeightValue: originalHeightValue == null && nullToAbsent
          ? const Value.absent()
          : Value(originalHeightValue),
      originalHeightUnit: originalHeightUnit == null && nullToAbsent
          ? const Value.absent()
          : Value(originalHeightUnit),
      canonicalHeightCentimeters:
          canonicalHeightCentimeters == null && nullToAbsent
          ? const Value.absent()
          : Value(canonicalHeightCentimeters),
      activityLevel: activityLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(activityLevel),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UsersTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UsersTableData(
      id: serializer.fromJson<String>(json['id']),
      displayName: serializer.fromJson<String>(json['displayName']),
      preferredWeightUnit: $UsersTableTable.$converterpreferredWeightUnit
          .fromJson(serializer.fromJson<String>(json['preferredWeightUnit'])),
      preferredBodyMetricUnit: $UsersTableTable
          .$converterpreferredBodyMetricUnit
          .fromJson(
            serializer.fromJson<String>(json['preferredBodyMetricUnit']),
          ),
      originalHeightValue: serializer.fromJson<double?>(
        json['originalHeightValue'],
      ),
      originalHeightUnit: $UsersTableTable.$converteroriginalHeightUnitn
          .fromJson(serializer.fromJson<String?>(json['originalHeightUnit'])),
      canonicalHeightCentimeters: serializer.fromJson<double?>(
        json['canonicalHeightCentimeters'],
      ),
      activityLevel: $UsersTableTable.$converteractivityLeveln.fromJson(
        serializer.fromJson<String?>(json['activityLevel']),
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'displayName': serializer.toJson<String>(displayName),
      'preferredWeightUnit': serializer.toJson<String>(
        $UsersTableTable.$converterpreferredWeightUnit.toJson(
          preferredWeightUnit,
        ),
      ),
      'preferredBodyMetricUnit': serializer.toJson<String>(
        $UsersTableTable.$converterpreferredBodyMetricUnit.toJson(
          preferredBodyMetricUnit,
        ),
      ),
      'originalHeightValue': serializer.toJson<double?>(originalHeightValue),
      'originalHeightUnit': serializer.toJson<String?>(
        $UsersTableTable.$converteroriginalHeightUnitn.toJson(
          originalHeightUnit,
        ),
      ),
      'canonicalHeightCentimeters': serializer.toJson<double?>(
        canonicalHeightCentimeters,
      ),
      'activityLevel': serializer.toJson<String?>(
        $UsersTableTable.$converteractivityLeveln.toJson(activityLevel),
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UsersTableData copyWith({
    String? id,
    String? displayName,
    WeightUnit? preferredWeightUnit,
    BodyMetricUnit? preferredBodyMetricUnit,
    Value<double?> originalHeightValue = const Value.absent(),
    Value<BodyMetricUnit?> originalHeightUnit = const Value.absent(),
    Value<double?> canonicalHeightCentimeters = const Value.absent(),
    Value<ActivityLevel?> activityLevel = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => UsersTableData(
    id: id ?? this.id,
    displayName: displayName ?? this.displayName,
    preferredWeightUnit: preferredWeightUnit ?? this.preferredWeightUnit,
    preferredBodyMetricUnit:
        preferredBodyMetricUnit ?? this.preferredBodyMetricUnit,
    originalHeightValue: originalHeightValue.present
        ? originalHeightValue.value
        : this.originalHeightValue,
    originalHeightUnit: originalHeightUnit.present
        ? originalHeightUnit.value
        : this.originalHeightUnit,
    canonicalHeightCentimeters: canonicalHeightCentimeters.present
        ? canonicalHeightCentimeters.value
        : this.canonicalHeightCentimeters,
    activityLevel: activityLevel.present
        ? activityLevel.value
        : this.activityLevel,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UsersTableData copyWithCompanion(UsersTableCompanion data) {
    return UsersTableData(
      id: data.id.present ? data.id.value : this.id,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      preferredWeightUnit: data.preferredWeightUnit.present
          ? data.preferredWeightUnit.value
          : this.preferredWeightUnit,
      preferredBodyMetricUnit: data.preferredBodyMetricUnit.present
          ? data.preferredBodyMetricUnit.value
          : this.preferredBodyMetricUnit,
      originalHeightValue: data.originalHeightValue.present
          ? data.originalHeightValue.value
          : this.originalHeightValue,
      originalHeightUnit: data.originalHeightUnit.present
          ? data.originalHeightUnit.value
          : this.originalHeightUnit,
      canonicalHeightCentimeters: data.canonicalHeightCentimeters.present
          ? data.canonicalHeightCentimeters.value
          : this.canonicalHeightCentimeters,
      activityLevel: data.activityLevel.present
          ? data.activityLevel.value
          : this.activityLevel,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UsersTableData(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('preferredWeightUnit: $preferredWeightUnit, ')
          ..write('preferredBodyMetricUnit: $preferredBodyMetricUnit, ')
          ..write('originalHeightValue: $originalHeightValue, ')
          ..write('originalHeightUnit: $originalHeightUnit, ')
          ..write('canonicalHeightCentimeters: $canonicalHeightCentimeters, ')
          ..write('activityLevel: $activityLevel, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    displayName,
    preferredWeightUnit,
    preferredBodyMetricUnit,
    originalHeightValue,
    originalHeightUnit,
    canonicalHeightCentimeters,
    activityLevel,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UsersTableData &&
          other.id == this.id &&
          other.displayName == this.displayName &&
          other.preferredWeightUnit == this.preferredWeightUnit &&
          other.preferredBodyMetricUnit == this.preferredBodyMetricUnit &&
          other.originalHeightValue == this.originalHeightValue &&
          other.originalHeightUnit == this.originalHeightUnit &&
          other.canonicalHeightCentimeters == this.canonicalHeightCentimeters &&
          other.activityLevel == this.activityLevel &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UsersTableCompanion extends UpdateCompanion<UsersTableData> {
  final Value<String> id;
  final Value<String> displayName;
  final Value<WeightUnit> preferredWeightUnit;
  final Value<BodyMetricUnit> preferredBodyMetricUnit;
  final Value<double?> originalHeightValue;
  final Value<BodyMetricUnit?> originalHeightUnit;
  final Value<double?> canonicalHeightCentimeters;
  final Value<ActivityLevel?> activityLevel;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const UsersTableCompanion({
    this.id = const Value.absent(),
    this.displayName = const Value.absent(),
    this.preferredWeightUnit = const Value.absent(),
    this.preferredBodyMetricUnit = const Value.absent(),
    this.originalHeightValue = const Value.absent(),
    this.originalHeightUnit = const Value.absent(),
    this.canonicalHeightCentimeters = const Value.absent(),
    this.activityLevel = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersTableCompanion.insert({
    required String id,
    required String displayName,
    required WeightUnit preferredWeightUnit,
    required BodyMetricUnit preferredBodyMetricUnit,
    this.originalHeightValue = const Value.absent(),
    this.originalHeightUnit = const Value.absent(),
    this.canonicalHeightCentimeters = const Value.absent(),
    this.activityLevel = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       displayName = Value(displayName),
       preferredWeightUnit = Value(preferredWeightUnit),
       preferredBodyMetricUnit = Value(preferredBodyMetricUnit),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<UsersTableData> custom({
    Expression<String>? id,
    Expression<String>? displayName,
    Expression<String>? preferredWeightUnit,
    Expression<String>? preferredBodyMetricUnit,
    Expression<double>? originalHeightValue,
    Expression<String>? originalHeightUnit,
    Expression<double>? canonicalHeightCentimeters,
    Expression<String>? activityLevel,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (displayName != null) 'display_name': displayName,
      if (preferredWeightUnit != null)
        'preferred_weight_unit': preferredWeightUnit,
      if (preferredBodyMetricUnit != null)
        'preferred_body_metric_unit': preferredBodyMetricUnit,
      if (originalHeightValue != null)
        'original_height_value': originalHeightValue,
      if (originalHeightUnit != null)
        'original_height_unit': originalHeightUnit,
      if (canonicalHeightCentimeters != null)
        'canonical_height_centimeters': canonicalHeightCentimeters,
      if (activityLevel != null) 'activity_level': activityLevel,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersTableCompanion copyWith({
    Value<String>? id,
    Value<String>? displayName,
    Value<WeightUnit>? preferredWeightUnit,
    Value<BodyMetricUnit>? preferredBodyMetricUnit,
    Value<double?>? originalHeightValue,
    Value<BodyMetricUnit?>? originalHeightUnit,
    Value<double?>? canonicalHeightCentimeters,
    Value<ActivityLevel?>? activityLevel,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return UsersTableCompanion(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      preferredWeightUnit: preferredWeightUnit ?? this.preferredWeightUnit,
      preferredBodyMetricUnit:
          preferredBodyMetricUnit ?? this.preferredBodyMetricUnit,
      originalHeightValue: originalHeightValue ?? this.originalHeightValue,
      originalHeightUnit: originalHeightUnit ?? this.originalHeightUnit,
      canonicalHeightCentimeters:
          canonicalHeightCentimeters ?? this.canonicalHeightCentimeters,
      activityLevel: activityLevel ?? this.activityLevel,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (preferredWeightUnit.present) {
      map['preferred_weight_unit'] = Variable<String>(
        $UsersTableTable.$converterpreferredWeightUnit.toSql(
          preferredWeightUnit.value,
        ),
      );
    }
    if (preferredBodyMetricUnit.present) {
      map['preferred_body_metric_unit'] = Variable<String>(
        $UsersTableTable.$converterpreferredBodyMetricUnit.toSql(
          preferredBodyMetricUnit.value,
        ),
      );
    }
    if (originalHeightValue.present) {
      map['original_height_value'] = Variable<double>(
        originalHeightValue.value,
      );
    }
    if (originalHeightUnit.present) {
      map['original_height_unit'] = Variable<String>(
        $UsersTableTable.$converteroriginalHeightUnitn.toSql(
          originalHeightUnit.value,
        ),
      );
    }
    if (canonicalHeightCentimeters.present) {
      map['canonical_height_centimeters'] = Variable<double>(
        canonicalHeightCentimeters.value,
      );
    }
    if (activityLevel.present) {
      map['activity_level'] = Variable<String>(
        $UsersTableTable.$converteractivityLeveln.toSql(activityLevel.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersTableCompanion(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('preferredWeightUnit: $preferredWeightUnit, ')
          ..write('preferredBodyMetricUnit: $preferredBodyMetricUnit, ')
          ..write('originalHeightValue: $originalHeightValue, ')
          ..write('originalHeightUnit: $originalHeightUnit, ')
          ..write('canonicalHeightCentimeters: $canonicalHeightCentimeters, ')
          ..write('activityLevel: $activityLevel, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GoalsTableTable extends GoalsTable
    with TableInfo<$GoalsTableTable, GoalsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<GoalType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<GoalType>($GoalsTableTable.$convertertype);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _originalTargetWeightValueMeta =
      const VerificationMeta('originalTargetWeightValue');
  @override
  late final GeneratedColumn<double> originalTargetWeightValue =
      GeneratedColumn<double>(
        'original_target_weight_value',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  @override
  late final GeneratedColumnWithTypeConverter<WeightUnit?, String>
  originalTargetWeightUnit =
      GeneratedColumn<String>(
        'original_target_weight_unit',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<WeightUnit?>(
        $GoalsTableTable.$converteroriginalTargetWeightUnitn,
      );
  static const VerificationMeta _canonicalTargetWeightKilogramsMeta =
      const VerificationMeta('canonicalTargetWeightKilograms');
  @override
  late final GeneratedColumn<double> canonicalTargetWeightKilograms =
      GeneratedColumn<double>(
        'canonical_target_weight_kilograms',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _targetCaloriesMeta = const VerificationMeta(
    'targetCalories',
  );
  @override
  late final GeneratedColumn<int> targetCalories = GeneratedColumn<int>(
    'target_calories',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetProteinGramsMeta =
      const VerificationMeta('targetProteinGrams');
  @override
  late final GeneratedColumn<double> targetProteinGrams =
      GeneratedColumn<double>(
        'target_protein_grams',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _targetCarbsGramsMeta = const VerificationMeta(
    'targetCarbsGrams',
  );
  @override
  late final GeneratedColumn<double> targetCarbsGrams = GeneratedColumn<double>(
    'target_carbs_grams',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetFatGramsMeta = const VerificationMeta(
    'targetFatGrams',
  );
  @override
  late final GeneratedColumn<double> targetFatGrams = GeneratedColumn<double>(
    'target_fat_grams',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    title,
    originalTargetWeightValue,
    originalTargetWeightUnit,
    canonicalTargetWeightKilograms,
    targetCalories,
    targetProteinGrams,
    targetCarbsGrams,
    targetFatGrams,
    isActive,
    startedAt,
    endedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goals_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<GoalsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('original_target_weight_value')) {
      context.handle(
        _originalTargetWeightValueMeta,
        originalTargetWeightValue.isAcceptableOrUnknown(
          data['original_target_weight_value']!,
          _originalTargetWeightValueMeta,
        ),
      );
    }
    if (data.containsKey('canonical_target_weight_kilograms')) {
      context.handle(
        _canonicalTargetWeightKilogramsMeta,
        canonicalTargetWeightKilograms.isAcceptableOrUnknown(
          data['canonical_target_weight_kilograms']!,
          _canonicalTargetWeightKilogramsMeta,
        ),
      );
    }
    if (data.containsKey('target_calories')) {
      context.handle(
        _targetCaloriesMeta,
        targetCalories.isAcceptableOrUnknown(
          data['target_calories']!,
          _targetCaloriesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetCaloriesMeta);
    }
    if (data.containsKey('target_protein_grams')) {
      context.handle(
        _targetProteinGramsMeta,
        targetProteinGrams.isAcceptableOrUnknown(
          data['target_protein_grams']!,
          _targetProteinGramsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetProteinGramsMeta);
    }
    if (data.containsKey('target_carbs_grams')) {
      context.handle(
        _targetCarbsGramsMeta,
        targetCarbsGrams.isAcceptableOrUnknown(
          data['target_carbs_grams']!,
          _targetCarbsGramsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetCarbsGramsMeta);
    }
    if (data.containsKey('target_fat_grams')) {
      context.handle(
        _targetFatGramsMeta,
        targetFatGrams.isAcceptableOrUnknown(
          data['target_fat_grams']!,
          _targetFatGramsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetFatGramsMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GoalsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GoalsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      type: $GoalsTableTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      originalTargetWeightValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}original_target_weight_value'],
      ),
      originalTargetWeightUnit: $GoalsTableTable
          .$converteroriginalTargetWeightUnitn
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}original_target_weight_unit'],
            ),
          ),
      canonicalTargetWeightKilograms: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}canonical_target_weight_kilograms'],
      ),
      targetCalories: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_calories'],
      )!,
      targetProteinGrams: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_protein_grams'],
      )!,
      targetCarbsGrams: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_carbs_grams'],
      )!,
      targetFatGrams: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_fat_grams'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $GoalsTableTable createAlias(String alias) {
    return $GoalsTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<GoalType, String, String> $convertertype =
      const EnumNameConverter<GoalType>(GoalType.values);
  static JsonTypeConverter2<WeightUnit, String, String>
  $converteroriginalTargetWeightUnit = const EnumNameConverter<WeightUnit>(
    WeightUnit.values,
  );
  static JsonTypeConverter2<WeightUnit?, String?, String?>
  $converteroriginalTargetWeightUnitn = JsonTypeConverter2.asNullable(
    $converteroriginalTargetWeightUnit,
  );
}

class GoalsTableData extends DataClass implements Insertable<GoalsTableData> {
  final String id;
  final GoalType type;
  final String? title;
  final double? originalTargetWeightValue;
  final WeightUnit? originalTargetWeightUnit;
  final double? canonicalTargetWeightKilograms;
  final int targetCalories;
  final double targetProteinGrams;
  final double targetCarbsGrams;
  final double targetFatGrams;
  final bool isActive;
  final DateTime startedAt;
  final DateTime? endedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const GoalsTableData({
    required this.id,
    required this.type,
    this.title,
    this.originalTargetWeightValue,
    this.originalTargetWeightUnit,
    this.canonicalTargetWeightKilograms,
    required this.targetCalories,
    required this.targetProteinGrams,
    required this.targetCarbsGrams,
    required this.targetFatGrams,
    required this.isActive,
    required this.startedAt,
    this.endedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    {
      map['type'] = Variable<String>(
        $GoalsTableTable.$convertertype.toSql(type),
      );
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || originalTargetWeightValue != null) {
      map['original_target_weight_value'] = Variable<double>(
        originalTargetWeightValue,
      );
    }
    if (!nullToAbsent || originalTargetWeightUnit != null) {
      map['original_target_weight_unit'] = Variable<String>(
        $GoalsTableTable.$converteroriginalTargetWeightUnitn.toSql(
          originalTargetWeightUnit,
        ),
      );
    }
    if (!nullToAbsent || canonicalTargetWeightKilograms != null) {
      map['canonical_target_weight_kilograms'] = Variable<double>(
        canonicalTargetWeightKilograms,
      );
    }
    map['target_calories'] = Variable<int>(targetCalories);
    map['target_protein_grams'] = Variable<double>(targetProteinGrams);
    map['target_carbs_grams'] = Variable<double>(targetCarbsGrams);
    map['target_fat_grams'] = Variable<double>(targetFatGrams);
    map['is_active'] = Variable<bool>(isActive);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  GoalsTableCompanion toCompanion(bool nullToAbsent) {
    return GoalsTableCompanion(
      id: Value(id),
      type: Value(type),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      originalTargetWeightValue:
          originalTargetWeightValue == null && nullToAbsent
          ? const Value.absent()
          : Value(originalTargetWeightValue),
      originalTargetWeightUnit: originalTargetWeightUnit == null && nullToAbsent
          ? const Value.absent()
          : Value(originalTargetWeightUnit),
      canonicalTargetWeightKilograms:
          canonicalTargetWeightKilograms == null && nullToAbsent
          ? const Value.absent()
          : Value(canonicalTargetWeightKilograms),
      targetCalories: Value(targetCalories),
      targetProteinGrams: Value(targetProteinGrams),
      targetCarbsGrams: Value(targetCarbsGrams),
      targetFatGrams: Value(targetFatGrams),
      isActive: Value(isActive),
      startedAt: Value(startedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory GoalsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GoalsTableData(
      id: serializer.fromJson<String>(json['id']),
      type: $GoalsTableTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      title: serializer.fromJson<String?>(json['title']),
      originalTargetWeightValue: serializer.fromJson<double?>(
        json['originalTargetWeightValue'],
      ),
      originalTargetWeightUnit: $GoalsTableTable
          .$converteroriginalTargetWeightUnitn
          .fromJson(
            serializer.fromJson<String?>(json['originalTargetWeightUnit']),
          ),
      canonicalTargetWeightKilograms: serializer.fromJson<double?>(
        json['canonicalTargetWeightKilograms'],
      ),
      targetCalories: serializer.fromJson<int>(json['targetCalories']),
      targetProteinGrams: serializer.fromJson<double>(
        json['targetProteinGrams'],
      ),
      targetCarbsGrams: serializer.fromJson<double>(json['targetCarbsGrams']),
      targetFatGrams: serializer.fromJson<double>(json['targetFatGrams']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(
        $GoalsTableTable.$convertertype.toJson(type),
      ),
      'title': serializer.toJson<String?>(title),
      'originalTargetWeightValue': serializer.toJson<double?>(
        originalTargetWeightValue,
      ),
      'originalTargetWeightUnit': serializer.toJson<String?>(
        $GoalsTableTable.$converteroriginalTargetWeightUnitn.toJson(
          originalTargetWeightUnit,
        ),
      ),
      'canonicalTargetWeightKilograms': serializer.toJson<double?>(
        canonicalTargetWeightKilograms,
      ),
      'targetCalories': serializer.toJson<int>(targetCalories),
      'targetProteinGrams': serializer.toJson<double>(targetProteinGrams),
      'targetCarbsGrams': serializer.toJson<double>(targetCarbsGrams),
      'targetFatGrams': serializer.toJson<double>(targetFatGrams),
      'isActive': serializer.toJson<bool>(isActive),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  GoalsTableData copyWith({
    String? id,
    GoalType? type,
    Value<String?> title = const Value.absent(),
    Value<double?> originalTargetWeightValue = const Value.absent(),
    Value<WeightUnit?> originalTargetWeightUnit = const Value.absent(),
    Value<double?> canonicalTargetWeightKilograms = const Value.absent(),
    int? targetCalories,
    double? targetProteinGrams,
    double? targetCarbsGrams,
    double? targetFatGrams,
    bool? isActive,
    DateTime? startedAt,
    Value<DateTime?> endedAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => GoalsTableData(
    id: id ?? this.id,
    type: type ?? this.type,
    title: title.present ? title.value : this.title,
    originalTargetWeightValue: originalTargetWeightValue.present
        ? originalTargetWeightValue.value
        : this.originalTargetWeightValue,
    originalTargetWeightUnit: originalTargetWeightUnit.present
        ? originalTargetWeightUnit.value
        : this.originalTargetWeightUnit,
    canonicalTargetWeightKilograms: canonicalTargetWeightKilograms.present
        ? canonicalTargetWeightKilograms.value
        : this.canonicalTargetWeightKilograms,
    targetCalories: targetCalories ?? this.targetCalories,
    targetProteinGrams: targetProteinGrams ?? this.targetProteinGrams,
    targetCarbsGrams: targetCarbsGrams ?? this.targetCarbsGrams,
    targetFatGrams: targetFatGrams ?? this.targetFatGrams,
    isActive: isActive ?? this.isActive,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  GoalsTableData copyWithCompanion(GoalsTableCompanion data) {
    return GoalsTableData(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      title: data.title.present ? data.title.value : this.title,
      originalTargetWeightValue: data.originalTargetWeightValue.present
          ? data.originalTargetWeightValue.value
          : this.originalTargetWeightValue,
      originalTargetWeightUnit: data.originalTargetWeightUnit.present
          ? data.originalTargetWeightUnit.value
          : this.originalTargetWeightUnit,
      canonicalTargetWeightKilograms:
          data.canonicalTargetWeightKilograms.present
          ? data.canonicalTargetWeightKilograms.value
          : this.canonicalTargetWeightKilograms,
      targetCalories: data.targetCalories.present
          ? data.targetCalories.value
          : this.targetCalories,
      targetProteinGrams: data.targetProteinGrams.present
          ? data.targetProteinGrams.value
          : this.targetProteinGrams,
      targetCarbsGrams: data.targetCarbsGrams.present
          ? data.targetCarbsGrams.value
          : this.targetCarbsGrams,
      targetFatGrams: data.targetFatGrams.present
          ? data.targetFatGrams.value
          : this.targetFatGrams,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GoalsTableData(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('originalTargetWeightValue: $originalTargetWeightValue, ')
          ..write('originalTargetWeightUnit: $originalTargetWeightUnit, ')
          ..write(
            'canonicalTargetWeightKilograms: $canonicalTargetWeightKilograms, ',
          )
          ..write('targetCalories: $targetCalories, ')
          ..write('targetProteinGrams: $targetProteinGrams, ')
          ..write('targetCarbsGrams: $targetCarbsGrams, ')
          ..write('targetFatGrams: $targetFatGrams, ')
          ..write('isActive: $isActive, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    type,
    title,
    originalTargetWeightValue,
    originalTargetWeightUnit,
    canonicalTargetWeightKilograms,
    targetCalories,
    targetProteinGrams,
    targetCarbsGrams,
    targetFatGrams,
    isActive,
    startedAt,
    endedAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GoalsTableData &&
          other.id == this.id &&
          other.type == this.type &&
          other.title == this.title &&
          other.originalTargetWeightValue == this.originalTargetWeightValue &&
          other.originalTargetWeightUnit == this.originalTargetWeightUnit &&
          other.canonicalTargetWeightKilograms ==
              this.canonicalTargetWeightKilograms &&
          other.targetCalories == this.targetCalories &&
          other.targetProteinGrams == this.targetProteinGrams &&
          other.targetCarbsGrams == this.targetCarbsGrams &&
          other.targetFatGrams == this.targetFatGrams &&
          other.isActive == this.isActive &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class GoalsTableCompanion extends UpdateCompanion<GoalsTableData> {
  final Value<String> id;
  final Value<GoalType> type;
  final Value<String?> title;
  final Value<double?> originalTargetWeightValue;
  final Value<WeightUnit?> originalTargetWeightUnit;
  final Value<double?> canonicalTargetWeightKilograms;
  final Value<int> targetCalories;
  final Value<double> targetProteinGrams;
  final Value<double> targetCarbsGrams;
  final Value<double> targetFatGrams;
  final Value<bool> isActive;
  final Value<DateTime> startedAt;
  final Value<DateTime?> endedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const GoalsTableCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.title = const Value.absent(),
    this.originalTargetWeightValue = const Value.absent(),
    this.originalTargetWeightUnit = const Value.absent(),
    this.canonicalTargetWeightKilograms = const Value.absent(),
    this.targetCalories = const Value.absent(),
    this.targetProteinGrams = const Value.absent(),
    this.targetCarbsGrams = const Value.absent(),
    this.targetFatGrams = const Value.absent(),
    this.isActive = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GoalsTableCompanion.insert({
    required String id,
    required GoalType type,
    this.title = const Value.absent(),
    this.originalTargetWeightValue = const Value.absent(),
    this.originalTargetWeightUnit = const Value.absent(),
    this.canonicalTargetWeightKilograms = const Value.absent(),
    required int targetCalories,
    required double targetProteinGrams,
    required double targetCarbsGrams,
    required double targetFatGrams,
    this.isActive = const Value.absent(),
    required DateTime startedAt,
    this.endedAt = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       type = Value(type),
       targetCalories = Value(targetCalories),
       targetProteinGrams = Value(targetProteinGrams),
       targetCarbsGrams = Value(targetCarbsGrams),
       targetFatGrams = Value(targetFatGrams),
       startedAt = Value(startedAt),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<GoalsTableData> custom({
    Expression<String>? id,
    Expression<String>? type,
    Expression<String>? title,
    Expression<double>? originalTargetWeightValue,
    Expression<String>? originalTargetWeightUnit,
    Expression<double>? canonicalTargetWeightKilograms,
    Expression<int>? targetCalories,
    Expression<double>? targetProteinGrams,
    Expression<double>? targetCarbsGrams,
    Expression<double>? targetFatGrams,
    Expression<bool>? isActive,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (title != null) 'title': title,
      if (originalTargetWeightValue != null)
        'original_target_weight_value': originalTargetWeightValue,
      if (originalTargetWeightUnit != null)
        'original_target_weight_unit': originalTargetWeightUnit,
      if (canonicalTargetWeightKilograms != null)
        'canonical_target_weight_kilograms': canonicalTargetWeightKilograms,
      if (targetCalories != null) 'target_calories': targetCalories,
      if (targetProteinGrams != null)
        'target_protein_grams': targetProteinGrams,
      if (targetCarbsGrams != null) 'target_carbs_grams': targetCarbsGrams,
      if (targetFatGrams != null) 'target_fat_grams': targetFatGrams,
      if (isActive != null) 'is_active': isActive,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GoalsTableCompanion copyWith({
    Value<String>? id,
    Value<GoalType>? type,
    Value<String?>? title,
    Value<double?>? originalTargetWeightValue,
    Value<WeightUnit?>? originalTargetWeightUnit,
    Value<double?>? canonicalTargetWeightKilograms,
    Value<int>? targetCalories,
    Value<double>? targetProteinGrams,
    Value<double>? targetCarbsGrams,
    Value<double>? targetFatGrams,
    Value<bool>? isActive,
    Value<DateTime>? startedAt,
    Value<DateTime?>? endedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return GoalsTableCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      originalTargetWeightValue:
          originalTargetWeightValue ?? this.originalTargetWeightValue,
      originalTargetWeightUnit:
          originalTargetWeightUnit ?? this.originalTargetWeightUnit,
      canonicalTargetWeightKilograms:
          canonicalTargetWeightKilograms ?? this.canonicalTargetWeightKilograms,
      targetCalories: targetCalories ?? this.targetCalories,
      targetProteinGrams: targetProteinGrams ?? this.targetProteinGrams,
      targetCarbsGrams: targetCarbsGrams ?? this.targetCarbsGrams,
      targetFatGrams: targetFatGrams ?? this.targetFatGrams,
      isActive: isActive ?? this.isActive,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $GoalsTableTable.$convertertype.toSql(type.value),
      );
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (originalTargetWeightValue.present) {
      map['original_target_weight_value'] = Variable<double>(
        originalTargetWeightValue.value,
      );
    }
    if (originalTargetWeightUnit.present) {
      map['original_target_weight_unit'] = Variable<String>(
        $GoalsTableTable.$converteroriginalTargetWeightUnitn.toSql(
          originalTargetWeightUnit.value,
        ),
      );
    }
    if (canonicalTargetWeightKilograms.present) {
      map['canonical_target_weight_kilograms'] = Variable<double>(
        canonicalTargetWeightKilograms.value,
      );
    }
    if (targetCalories.present) {
      map['target_calories'] = Variable<int>(targetCalories.value);
    }
    if (targetProteinGrams.present) {
      map['target_protein_grams'] = Variable<double>(targetProteinGrams.value);
    }
    if (targetCarbsGrams.present) {
      map['target_carbs_grams'] = Variable<double>(targetCarbsGrams.value);
    }
    if (targetFatGrams.present) {
      map['target_fat_grams'] = Variable<double>(targetFatGrams.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalsTableCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('originalTargetWeightValue: $originalTargetWeightValue, ')
          ..write('originalTargetWeightUnit: $originalTargetWeightUnit, ')
          ..write(
            'canonicalTargetWeightKilograms: $canonicalTargetWeightKilograms, ',
          )
          ..write('targetCalories: $targetCalories, ')
          ..write('targetProteinGrams: $targetProteinGrams, ')
          ..write('targetCarbsGrams: $targetCarbsGrams, ')
          ..write('targetFatGrams: $targetFatGrams, ')
          ..write('isActive: $isActive, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExercisesTableTable extends ExercisesTable
    with TableInfo<$ExercisesTableTable, ExercisesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExercisesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _primaryMuscleGroupMeta =
      const VerificationMeta('primaryMuscleGroup');
  @override
  late final GeneratedColumn<String> primaryMuscleGroup =
      GeneratedColumn<String>(
        'primary_muscle_group',
        aliasedName,
        false,
        additionalChecks: GeneratedColumn.checkTextLength(
          minTextLength: 1,
          maxTextLength: 64,
        ),
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _isBuiltInMeta = const VerificationMeta(
    'isBuiltIn',
  );
  @override
  late final GeneratedColumn<bool> isBuiltIn = GeneratedColumn<bool>(
    'is_built_in',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_built_in" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    primaryMuscleGroup,
    isBuiltIn,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercises_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExercisesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('primary_muscle_group')) {
      context.handle(
        _primaryMuscleGroupMeta,
        primaryMuscleGroup.isAcceptableOrUnknown(
          data['primary_muscle_group']!,
          _primaryMuscleGroupMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_primaryMuscleGroupMeta);
    }
    if (data.containsKey('is_built_in')) {
      context.handle(
        _isBuiltInMeta,
        isBuiltIn.isAcceptableOrUnknown(data['is_built_in']!, _isBuiltInMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExercisesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExercisesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      primaryMuscleGroup: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}primary_muscle_group'],
      )!,
      isBuiltIn: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_built_in'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ExercisesTableTable createAlias(String alias) {
    return $ExercisesTableTable(attachedDatabase, alias);
  }
}

class ExercisesTableData extends DataClass
    implements Insertable<ExercisesTableData> {
  final String id;
  final String name;
  final String primaryMuscleGroup;
  final bool isBuiltIn;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ExercisesTableData({
    required this.id,
    required this.name,
    required this.primaryMuscleGroup,
    required this.isBuiltIn,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['primary_muscle_group'] = Variable<String>(primaryMuscleGroup);
    map['is_built_in'] = Variable<bool>(isBuiltIn);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ExercisesTableCompanion toCompanion(bool nullToAbsent) {
    return ExercisesTableCompanion(
      id: Value(id),
      name: Value(name),
      primaryMuscleGroup: Value(primaryMuscleGroup),
      isBuiltIn: Value(isBuiltIn),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ExercisesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExercisesTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      primaryMuscleGroup: serializer.fromJson<String>(
        json['primaryMuscleGroup'],
      ),
      isBuiltIn: serializer.fromJson<bool>(json['isBuiltIn']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'primaryMuscleGroup': serializer.toJson<String>(primaryMuscleGroup),
      'isBuiltIn': serializer.toJson<bool>(isBuiltIn),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ExercisesTableData copyWith({
    String? id,
    String? name,
    String? primaryMuscleGroup,
    bool? isBuiltIn,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ExercisesTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    primaryMuscleGroup: primaryMuscleGroup ?? this.primaryMuscleGroup,
    isBuiltIn: isBuiltIn ?? this.isBuiltIn,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ExercisesTableData copyWithCompanion(ExercisesTableCompanion data) {
    return ExercisesTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      primaryMuscleGroup: data.primaryMuscleGroup.present
          ? data.primaryMuscleGroup.value
          : this.primaryMuscleGroup,
      isBuiltIn: data.isBuiltIn.present ? data.isBuiltIn.value : this.isBuiltIn,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExercisesTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('primaryMuscleGroup: $primaryMuscleGroup, ')
          ..write('isBuiltIn: $isBuiltIn, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    primaryMuscleGroup,
    isBuiltIn,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExercisesTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.primaryMuscleGroup == this.primaryMuscleGroup &&
          other.isBuiltIn == this.isBuiltIn &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ExercisesTableCompanion extends UpdateCompanion<ExercisesTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> primaryMuscleGroup;
  final Value<bool> isBuiltIn;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ExercisesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.primaryMuscleGroup = const Value.absent(),
    this.isBuiltIn = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExercisesTableCompanion.insert({
    required String id,
    required String name,
    required String primaryMuscleGroup,
    this.isBuiltIn = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       primaryMuscleGroup = Value(primaryMuscleGroup),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ExercisesTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? primaryMuscleGroup,
    Expression<bool>? isBuiltIn,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (primaryMuscleGroup != null)
        'primary_muscle_group': primaryMuscleGroup,
      if (isBuiltIn != null) 'is_built_in': isBuiltIn,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExercisesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? primaryMuscleGroup,
    Value<bool>? isBuiltIn,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ExercisesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      primaryMuscleGroup: primaryMuscleGroup ?? this.primaryMuscleGroup,
      isBuiltIn: isBuiltIn ?? this.isBuiltIn,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (primaryMuscleGroup.present) {
      map['primary_muscle_group'] = Variable<String>(primaryMuscleGroup.value);
    }
    if (isBuiltIn.present) {
      map['is_built_in'] = Variable<bool>(isBuiltIn.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExercisesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('primaryMuscleGroup: $primaryMuscleGroup, ')
          ..write('isBuiltIn: $isBuiltIn, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkoutTemplatesTableTable extends WorkoutTemplatesTable
    with TableInfo<$WorkoutTemplatesTableTable, WorkoutTemplatesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutTemplatesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, notes, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_templates_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkoutTemplatesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutTemplatesTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutTemplatesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $WorkoutTemplatesTableTable createAlias(String alias) {
    return $WorkoutTemplatesTableTable(attachedDatabase, alias);
  }
}

class WorkoutTemplatesTableData extends DataClass
    implements Insertable<WorkoutTemplatesTableData> {
  final String id;
  final String name;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const WorkoutTemplatesTableData({
    required this.id,
    required this.name,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  WorkoutTemplatesTableCompanion toCompanion(bool nullToAbsent) {
    return WorkoutTemplatesTableCompanion(
      id: Value(id),
      name: Value(name),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory WorkoutTemplatesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutTemplatesTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  WorkoutTemplatesTableData copyWith({
    String? id,
    String? name,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => WorkoutTemplatesTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  WorkoutTemplatesTableData copyWithCompanion(
    WorkoutTemplatesTableCompanion data,
  ) {
    return WorkoutTemplatesTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutTemplatesTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, notes, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutTemplatesTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WorkoutTemplatesTableCompanion
    extends UpdateCompanion<WorkoutTemplatesTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const WorkoutTemplatesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutTemplatesTableCompanion.insert({
    required String id,
    required String name,
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<WorkoutTemplatesTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutTemplatesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return WorkoutTemplatesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutTemplatesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkoutTemplateItemsTableTable extends WorkoutTemplateItemsTable
    with
        TableInfo<
          $WorkoutTemplateItemsTableTable,
          WorkoutTemplateItemsTableData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutTemplateItemsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _templateIdMeta = const VerificationMeta(
    'templateId',
  );
  @override
  late final GeneratedColumn<String> templateId = GeneratedColumn<String>(
    'template_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES workout_templates_table (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES exercises_table (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _orderIndexMeta = const VerificationMeta(
    'orderIndex',
  );
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
    'order_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetSetsMeta = const VerificationMeta(
    'targetSets',
  );
  @override
  late final GeneratedColumn<int> targetSets = GeneratedColumn<int>(
    'target_sets',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetRepsMeta = const VerificationMeta(
    'targetReps',
  );
  @override
  late final GeneratedColumn<String> targetReps = GeneratedColumn<String>(
    'target_reps',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 32,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    templateId,
    exerciseId,
    orderIndex,
    targetSets,
    targetReps,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_template_items_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkoutTemplateItemsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('template_id')) {
      context.handle(
        _templateIdMeta,
        templateId.isAcceptableOrUnknown(data['template_id']!, _templateIdMeta),
      );
    } else if (isInserting) {
      context.missing(_templateIdMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('order_index')) {
      context.handle(
        _orderIndexMeta,
        orderIndex.isAcceptableOrUnknown(data['order_index']!, _orderIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIndexMeta);
    }
    if (data.containsKey('target_sets')) {
      context.handle(
        _targetSetsMeta,
        targetSets.isAcceptableOrUnknown(data['target_sets']!, _targetSetsMeta),
      );
    } else if (isInserting) {
      context.missing(_targetSetsMeta);
    }
    if (data.containsKey('target_reps')) {
      context.handle(
        _targetRepsMeta,
        targetReps.isAcceptableOrUnknown(data['target_reps']!, _targetRepsMeta),
      );
    } else if (isInserting) {
      context.missing(_targetRepsMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutTemplateItemsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutTemplateItemsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      templateId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template_id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_id'],
      )!,
      orderIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order_index'],
      )!,
      targetSets: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_sets'],
      )!,
      targetReps: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_reps'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $WorkoutTemplateItemsTableTable createAlias(String alias) {
    return $WorkoutTemplateItemsTableTable(attachedDatabase, alias);
  }
}

class WorkoutTemplateItemsTableData extends DataClass
    implements Insertable<WorkoutTemplateItemsTableData> {
  final String id;
  final String templateId;
  final String exerciseId;
  final int orderIndex;
  final int targetSets;
  final String targetReps;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const WorkoutTemplateItemsTableData({
    required this.id,
    required this.templateId,
    required this.exerciseId,
    required this.orderIndex,
    required this.targetSets,
    required this.targetReps,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['template_id'] = Variable<String>(templateId);
    map['exercise_id'] = Variable<String>(exerciseId);
    map['order_index'] = Variable<int>(orderIndex);
    map['target_sets'] = Variable<int>(targetSets);
    map['target_reps'] = Variable<String>(targetReps);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  WorkoutTemplateItemsTableCompanion toCompanion(bool nullToAbsent) {
    return WorkoutTemplateItemsTableCompanion(
      id: Value(id),
      templateId: Value(templateId),
      exerciseId: Value(exerciseId),
      orderIndex: Value(orderIndex),
      targetSets: Value(targetSets),
      targetReps: Value(targetReps),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory WorkoutTemplateItemsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutTemplateItemsTableData(
      id: serializer.fromJson<String>(json['id']),
      templateId: serializer.fromJson<String>(json['templateId']),
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
      targetSets: serializer.fromJson<int>(json['targetSets']),
      targetReps: serializer.fromJson<String>(json['targetReps']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'templateId': serializer.toJson<String>(templateId),
      'exerciseId': serializer.toJson<String>(exerciseId),
      'orderIndex': serializer.toJson<int>(orderIndex),
      'targetSets': serializer.toJson<int>(targetSets),
      'targetReps': serializer.toJson<String>(targetReps),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  WorkoutTemplateItemsTableData copyWith({
    String? id,
    String? templateId,
    String? exerciseId,
    int? orderIndex,
    int? targetSets,
    String? targetReps,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => WorkoutTemplateItemsTableData(
    id: id ?? this.id,
    templateId: templateId ?? this.templateId,
    exerciseId: exerciseId ?? this.exerciseId,
    orderIndex: orderIndex ?? this.orderIndex,
    targetSets: targetSets ?? this.targetSets,
    targetReps: targetReps ?? this.targetReps,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  WorkoutTemplateItemsTableData copyWithCompanion(
    WorkoutTemplateItemsTableCompanion data,
  ) {
    return WorkoutTemplateItemsTableData(
      id: data.id.present ? data.id.value : this.id,
      templateId: data.templateId.present
          ? data.templateId.value
          : this.templateId,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      orderIndex: data.orderIndex.present
          ? data.orderIndex.value
          : this.orderIndex,
      targetSets: data.targetSets.present
          ? data.targetSets.value
          : this.targetSets,
      targetReps: data.targetReps.present
          ? data.targetReps.value
          : this.targetReps,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutTemplateItemsTableData(')
          ..write('id: $id, ')
          ..write('templateId: $templateId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('targetSets: $targetSets, ')
          ..write('targetReps: $targetReps, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    templateId,
    exerciseId,
    orderIndex,
    targetSets,
    targetReps,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutTemplateItemsTableData &&
          other.id == this.id &&
          other.templateId == this.templateId &&
          other.exerciseId == this.exerciseId &&
          other.orderIndex == this.orderIndex &&
          other.targetSets == this.targetSets &&
          other.targetReps == this.targetReps &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WorkoutTemplateItemsTableCompanion
    extends UpdateCompanion<WorkoutTemplateItemsTableData> {
  final Value<String> id;
  final Value<String> templateId;
  final Value<String> exerciseId;
  final Value<int> orderIndex;
  final Value<int> targetSets;
  final Value<String> targetReps;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const WorkoutTemplateItemsTableCompanion({
    this.id = const Value.absent(),
    this.templateId = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.targetSets = const Value.absent(),
    this.targetReps = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutTemplateItemsTableCompanion.insert({
    required String id,
    required String templateId,
    required String exerciseId,
    required int orderIndex,
    required int targetSets,
    required String targetReps,
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       templateId = Value(templateId),
       exerciseId = Value(exerciseId),
       orderIndex = Value(orderIndex),
       targetSets = Value(targetSets),
       targetReps = Value(targetReps),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<WorkoutTemplateItemsTableData> custom({
    Expression<String>? id,
    Expression<String>? templateId,
    Expression<String>? exerciseId,
    Expression<int>? orderIndex,
    Expression<int>? targetSets,
    Expression<String>? targetReps,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (templateId != null) 'template_id': templateId,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (orderIndex != null) 'order_index': orderIndex,
      if (targetSets != null) 'target_sets': targetSets,
      if (targetReps != null) 'target_reps': targetReps,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutTemplateItemsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? templateId,
    Value<String>? exerciseId,
    Value<int>? orderIndex,
    Value<int>? targetSets,
    Value<String>? targetReps,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return WorkoutTemplateItemsTableCompanion(
      id: id ?? this.id,
      templateId: templateId ?? this.templateId,
      exerciseId: exerciseId ?? this.exerciseId,
      orderIndex: orderIndex ?? this.orderIndex,
      targetSets: targetSets ?? this.targetSets,
      targetReps: targetReps ?? this.targetReps,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (templateId.present) {
      map['template_id'] = Variable<String>(templateId.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (targetSets.present) {
      map['target_sets'] = Variable<int>(targetSets.value);
    }
    if (targetReps.present) {
      map['target_reps'] = Variable<String>(targetReps.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutTemplateItemsTableCompanion(')
          ..write('id: $id, ')
          ..write('templateId: $templateId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('targetSets: $targetSets, ')
          ..write('targetReps: $targetReps, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkoutSessionsTableTable extends WorkoutSessionsTable
    with TableInfo<$WorkoutSessionsTableTable, WorkoutSessionsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutSessionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _templateIdMeta = const VerificationMeta(
    'templateId',
  );
  @override
  late final GeneratedColumn<String> templateId = GeneratedColumn<String>(
    'template_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES workout_templates_table (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    templateId,
    notes,
    startedAt,
    endedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_sessions_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkoutSessionsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('template_id')) {
      context.handle(
        _templateIdMeta,
        templateId.isAcceptableOrUnknown(data['template_id']!, _templateIdMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutSessionsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutSessionsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      templateId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template_id'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $WorkoutSessionsTableTable createAlias(String alias) {
    return $WorkoutSessionsTableTable(attachedDatabase, alias);
  }
}

class WorkoutSessionsTableData extends DataClass
    implements Insertable<WorkoutSessionsTableData> {
  final String id;
  final String? templateId;
  final String? notes;
  final DateTime startedAt;
  final DateTime? endedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const WorkoutSessionsTableData({
    required this.id,
    this.templateId,
    this.notes,
    required this.startedAt,
    this.endedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || templateId != null) {
      map['template_id'] = Variable<String>(templateId);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  WorkoutSessionsTableCompanion toCompanion(bool nullToAbsent) {
    return WorkoutSessionsTableCompanion(
      id: Value(id),
      templateId: templateId == null && nullToAbsent
          ? const Value.absent()
          : Value(templateId),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      startedAt: Value(startedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory WorkoutSessionsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutSessionsTableData(
      id: serializer.fromJson<String>(json['id']),
      templateId: serializer.fromJson<String?>(json['templateId']),
      notes: serializer.fromJson<String?>(json['notes']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'templateId': serializer.toJson<String?>(templateId),
      'notes': serializer.toJson<String?>(notes),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  WorkoutSessionsTableData copyWith({
    String? id,
    Value<String?> templateId = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? startedAt,
    Value<DateTime?> endedAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => WorkoutSessionsTableData(
    id: id ?? this.id,
    templateId: templateId.present ? templateId.value : this.templateId,
    notes: notes.present ? notes.value : this.notes,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  WorkoutSessionsTableData copyWithCompanion(
    WorkoutSessionsTableCompanion data,
  ) {
    return WorkoutSessionsTableData(
      id: data.id.present ? data.id.value : this.id,
      templateId: data.templateId.present
          ? data.templateId.value
          : this.templateId,
      notes: data.notes.present ? data.notes.value : this.notes,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutSessionsTableData(')
          ..write('id: $id, ')
          ..write('templateId: $templateId, ')
          ..write('notes: $notes, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    templateId,
    notes,
    startedAt,
    endedAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutSessionsTableData &&
          other.id == this.id &&
          other.templateId == this.templateId &&
          other.notes == this.notes &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WorkoutSessionsTableCompanion
    extends UpdateCompanion<WorkoutSessionsTableData> {
  final Value<String> id;
  final Value<String?> templateId;
  final Value<String?> notes;
  final Value<DateTime> startedAt;
  final Value<DateTime?> endedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const WorkoutSessionsTableCompanion({
    this.id = const Value.absent(),
    this.templateId = const Value.absent(),
    this.notes = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutSessionsTableCompanion.insert({
    required String id,
    this.templateId = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime startedAt,
    this.endedAt = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       startedAt = Value(startedAt),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<WorkoutSessionsTableData> custom({
    Expression<String>? id,
    Expression<String>? templateId,
    Expression<String>? notes,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (templateId != null) 'template_id': templateId,
      if (notes != null) 'notes': notes,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutSessionsTableCompanion copyWith({
    Value<String>? id,
    Value<String?>? templateId,
    Value<String?>? notes,
    Value<DateTime>? startedAt,
    Value<DateTime?>? endedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return WorkoutSessionsTableCompanion(
      id: id ?? this.id,
      templateId: templateId ?? this.templateId,
      notes: notes ?? this.notes,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (templateId.present) {
      map['template_id'] = Variable<String>(templateId.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutSessionsTableCompanion(')
          ..write('id: $id, ')
          ..write('templateId: $templateId, ')
          ..write('notes: $notes, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkoutExerciseEntriesTableTable extends WorkoutExerciseEntriesTable
    with
        TableInfo<
          $WorkoutExerciseEntriesTableTable,
          WorkoutExerciseEntriesTableData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutExerciseEntriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES workout_sessions_table (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES exercises_table (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _orderIndexMeta = const VerificationMeta(
    'orderIndex',
  );
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
    'order_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _supersetGroupIdMeta = const VerificationMeta(
    'supersetGroupId',
  );
  @override
  late final GeneratedColumn<String> supersetGroupId = GeneratedColumn<String>(
    'superset_group_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    exerciseId,
    orderIndex,
    notes,
    supersetGroupId,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_exercise_entries_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkoutExerciseEntriesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('order_index')) {
      context.handle(
        _orderIndexMeta,
        orderIndex.isAcceptableOrUnknown(data['order_index']!, _orderIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIndexMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('superset_group_id')) {
      context.handle(
        _supersetGroupIdMeta,
        supersetGroupId.isAcceptableOrUnknown(
          data['superset_group_id']!,
          _supersetGroupIdMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutExerciseEntriesTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutExerciseEntriesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_id'],
      )!,
      orderIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order_index'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      supersetGroupId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}superset_group_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $WorkoutExerciseEntriesTableTable createAlias(String alias) {
    return $WorkoutExerciseEntriesTableTable(attachedDatabase, alias);
  }
}

class WorkoutExerciseEntriesTableData extends DataClass
    implements Insertable<WorkoutExerciseEntriesTableData> {
  final String id;
  final String sessionId;
  final String exerciseId;
  final int orderIndex;
  final String? notes;
  final String? supersetGroupId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const WorkoutExerciseEntriesTableData({
    required this.id,
    required this.sessionId,
    required this.exerciseId,
    required this.orderIndex,
    this.notes,
    this.supersetGroupId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['exercise_id'] = Variable<String>(exerciseId);
    map['order_index'] = Variable<int>(orderIndex);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || supersetGroupId != null) {
      map['superset_group_id'] = Variable<String>(supersetGroupId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  WorkoutExerciseEntriesTableCompanion toCompanion(bool nullToAbsent) {
    return WorkoutExerciseEntriesTableCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      exerciseId: Value(exerciseId),
      orderIndex: Value(orderIndex),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      supersetGroupId: supersetGroupId == null && nullToAbsent
          ? const Value.absent()
          : Value(supersetGroupId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory WorkoutExerciseEntriesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutExerciseEntriesTableData(
      id: serializer.fromJson<String>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
      notes: serializer.fromJson<String?>(json['notes']),
      supersetGroupId: serializer.fromJson<String?>(json['supersetGroupId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'exerciseId': serializer.toJson<String>(exerciseId),
      'orderIndex': serializer.toJson<int>(orderIndex),
      'notes': serializer.toJson<String?>(notes),
      'supersetGroupId': serializer.toJson<String?>(supersetGroupId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  WorkoutExerciseEntriesTableData copyWith({
    String? id,
    String? sessionId,
    String? exerciseId,
    int? orderIndex,
    Value<String?> notes = const Value.absent(),
    Value<String?> supersetGroupId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => WorkoutExerciseEntriesTableData(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    exerciseId: exerciseId ?? this.exerciseId,
    orderIndex: orderIndex ?? this.orderIndex,
    notes: notes.present ? notes.value : this.notes,
    supersetGroupId: supersetGroupId.present
        ? supersetGroupId.value
        : this.supersetGroupId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  WorkoutExerciseEntriesTableData copyWithCompanion(
    WorkoutExerciseEntriesTableCompanion data,
  ) {
    return WorkoutExerciseEntriesTableData(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      orderIndex: data.orderIndex.present
          ? data.orderIndex.value
          : this.orderIndex,
      notes: data.notes.present ? data.notes.value : this.notes,
      supersetGroupId: data.supersetGroupId.present
          ? data.supersetGroupId.value
          : this.supersetGroupId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutExerciseEntriesTableData(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('notes: $notes, ')
          ..write('supersetGroupId: $supersetGroupId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sessionId,
    exerciseId,
    orderIndex,
    notes,
    supersetGroupId,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutExerciseEntriesTableData &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.exerciseId == this.exerciseId &&
          other.orderIndex == this.orderIndex &&
          other.notes == this.notes &&
          other.supersetGroupId == this.supersetGroupId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WorkoutExerciseEntriesTableCompanion
    extends UpdateCompanion<WorkoutExerciseEntriesTableData> {
  final Value<String> id;
  final Value<String> sessionId;
  final Value<String> exerciseId;
  final Value<int> orderIndex;
  final Value<String?> notes;
  final Value<String?> supersetGroupId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const WorkoutExerciseEntriesTableCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.notes = const Value.absent(),
    this.supersetGroupId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutExerciseEntriesTableCompanion.insert({
    required String id,
    required String sessionId,
    required String exerciseId,
    required int orderIndex,
    this.notes = const Value.absent(),
    this.supersetGroupId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sessionId = Value(sessionId),
       exerciseId = Value(exerciseId),
       orderIndex = Value(orderIndex),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<WorkoutExerciseEntriesTableData> custom({
    Expression<String>? id,
    Expression<String>? sessionId,
    Expression<String>? exerciseId,
    Expression<int>? orderIndex,
    Expression<String>? notes,
    Expression<String>? supersetGroupId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (orderIndex != null) 'order_index': orderIndex,
      if (notes != null) 'notes': notes,
      if (supersetGroupId != null) 'superset_group_id': supersetGroupId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutExerciseEntriesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? sessionId,
    Value<String>? exerciseId,
    Value<int>? orderIndex,
    Value<String?>? notes,
    Value<String?>? supersetGroupId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return WorkoutExerciseEntriesTableCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      exerciseId: exerciseId ?? this.exerciseId,
      orderIndex: orderIndex ?? this.orderIndex,
      notes: notes ?? this.notes,
      supersetGroupId: supersetGroupId ?? this.supersetGroupId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (supersetGroupId.present) {
      map['superset_group_id'] = Variable<String>(supersetGroupId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutExerciseEntriesTableCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('notes: $notes, ')
          ..write('supersetGroupId: $supersetGroupId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SetEntriesTableTable extends SetEntriesTable
    with TableInfo<$SetEntriesTableTable, SetEntriesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SetEntriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exerciseEntryIdMeta = const VerificationMeta(
    'exerciseEntryId',
  );
  @override
  late final GeneratedColumn<String> exerciseEntryId = GeneratedColumn<String>(
    'exercise_entry_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES workout_exercise_entries_table (id) ON DELETE CASCADE',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<SetType, String> setType =
      GeneratedColumn<String>(
        'set_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<SetType>($SetEntriesTableTable.$convertersetType);
  static const VerificationMeta _orderIndexMeta = const VerificationMeta(
    'orderIndex',
  );
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
    'order_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
    'reps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _originalWeightValueMeta =
      const VerificationMeta('originalWeightValue');
  @override
  late final GeneratedColumn<double> originalWeightValue =
      GeneratedColumn<double>(
        'original_weight_value',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  @override
  late final GeneratedColumnWithTypeConverter<WeightUnit?, String>
  originalWeightUnit =
      GeneratedColumn<String>(
        'original_weight_unit',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<WeightUnit?>(
        $SetEntriesTableTable.$converteroriginalWeightUnitn,
      );
  static const VerificationMeta _canonicalWeightKilogramsMeta =
      const VerificationMeta('canonicalWeightKilograms');
  @override
  late final GeneratedColumn<double> canonicalWeightKilograms =
      GeneratedColumn<double>(
        'canonical_weight_kilograms',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _rpeMeta = const VerificationMeta('rpe');
  @override
  late final GeneratedColumn<double> rpe = GeneratedColumn<double>(
    'rpe',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tempoMeta = const VerificationMeta('tempo');
  @override
  late final GeneratedColumn<String> tempo = GeneratedColumn<String>(
    'tempo',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 32,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _restSecondsMeta = const VerificationMeta(
    'restSeconds',
  );
  @override
  late final GeneratedColumn<int> restSeconds = GeneratedColumn<int>(
    'rest_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    exerciseEntryId,
    setType,
    orderIndex,
    reps,
    originalWeightValue,
    originalWeightUnit,
    canonicalWeightKilograms,
    rpe,
    tempo,
    restSeconds,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'set_entries_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<SetEntriesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('exercise_entry_id')) {
      context.handle(
        _exerciseEntryIdMeta,
        exerciseEntryId.isAcceptableOrUnknown(
          data['exercise_entry_id']!,
          _exerciseEntryIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_exerciseEntryIdMeta);
    }
    if (data.containsKey('order_index')) {
      context.handle(
        _orderIndexMeta,
        orderIndex.isAcceptableOrUnknown(data['order_index']!, _orderIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIndexMeta);
    }
    if (data.containsKey('reps')) {
      context.handle(
        _repsMeta,
        reps.isAcceptableOrUnknown(data['reps']!, _repsMeta),
      );
    } else if (isInserting) {
      context.missing(_repsMeta);
    }
    if (data.containsKey('original_weight_value')) {
      context.handle(
        _originalWeightValueMeta,
        originalWeightValue.isAcceptableOrUnknown(
          data['original_weight_value']!,
          _originalWeightValueMeta,
        ),
      );
    }
    if (data.containsKey('canonical_weight_kilograms')) {
      context.handle(
        _canonicalWeightKilogramsMeta,
        canonicalWeightKilograms.isAcceptableOrUnknown(
          data['canonical_weight_kilograms']!,
          _canonicalWeightKilogramsMeta,
        ),
      );
    }
    if (data.containsKey('rpe')) {
      context.handle(
        _rpeMeta,
        rpe.isAcceptableOrUnknown(data['rpe']!, _rpeMeta),
      );
    }
    if (data.containsKey('tempo')) {
      context.handle(
        _tempoMeta,
        tempo.isAcceptableOrUnknown(data['tempo']!, _tempoMeta),
      );
    }
    if (data.containsKey('rest_seconds')) {
      context.handle(
        _restSecondsMeta,
        restSeconds.isAcceptableOrUnknown(
          data['rest_seconds']!,
          _restSecondsMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SetEntriesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SetEntriesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      exerciseEntryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_entry_id'],
      )!,
      setType: $SetEntriesTableTable.$convertersetType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}set_type'],
        )!,
      ),
      orderIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order_index'],
      )!,
      reps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reps'],
      )!,
      originalWeightValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}original_weight_value'],
      ),
      originalWeightUnit: $SetEntriesTableTable.$converteroriginalWeightUnitn
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}original_weight_unit'],
            ),
          ),
      canonicalWeightKilograms: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}canonical_weight_kilograms'],
      ),
      rpe: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rpe'],
      ),
      tempo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tempo'],
      ),
      restSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rest_seconds'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SetEntriesTableTable createAlias(String alias) {
    return $SetEntriesTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SetType, String, String> $convertersetType =
      const EnumNameConverter<SetType>(SetType.values);
  static JsonTypeConverter2<WeightUnit, String, String>
  $converteroriginalWeightUnit = const EnumNameConverter<WeightUnit>(
    WeightUnit.values,
  );
  static JsonTypeConverter2<WeightUnit?, String?, String?>
  $converteroriginalWeightUnitn = JsonTypeConverter2.asNullable(
    $converteroriginalWeightUnit,
  );
}

class SetEntriesTableData extends DataClass
    implements Insertable<SetEntriesTableData> {
  final String id;
  final String exerciseEntryId;
  final SetType setType;
  final int orderIndex;
  final int reps;
  final double? originalWeightValue;
  final WeightUnit? originalWeightUnit;
  final double? canonicalWeightKilograms;
  final double? rpe;
  final String? tempo;
  final int? restSeconds;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SetEntriesTableData({
    required this.id,
    required this.exerciseEntryId,
    required this.setType,
    required this.orderIndex,
    required this.reps,
    this.originalWeightValue,
    this.originalWeightUnit,
    this.canonicalWeightKilograms,
    this.rpe,
    this.tempo,
    this.restSeconds,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['exercise_entry_id'] = Variable<String>(exerciseEntryId);
    {
      map['set_type'] = Variable<String>(
        $SetEntriesTableTable.$convertersetType.toSql(setType),
      );
    }
    map['order_index'] = Variable<int>(orderIndex);
    map['reps'] = Variable<int>(reps);
    if (!nullToAbsent || originalWeightValue != null) {
      map['original_weight_value'] = Variable<double>(originalWeightValue);
    }
    if (!nullToAbsent || originalWeightUnit != null) {
      map['original_weight_unit'] = Variable<String>(
        $SetEntriesTableTable.$converteroriginalWeightUnitn.toSql(
          originalWeightUnit,
        ),
      );
    }
    if (!nullToAbsent || canonicalWeightKilograms != null) {
      map['canonical_weight_kilograms'] = Variable<double>(
        canonicalWeightKilograms,
      );
    }
    if (!nullToAbsent || rpe != null) {
      map['rpe'] = Variable<double>(rpe);
    }
    if (!nullToAbsent || tempo != null) {
      map['tempo'] = Variable<String>(tempo);
    }
    if (!nullToAbsent || restSeconds != null) {
      map['rest_seconds'] = Variable<int>(restSeconds);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SetEntriesTableCompanion toCompanion(bool nullToAbsent) {
    return SetEntriesTableCompanion(
      id: Value(id),
      exerciseEntryId: Value(exerciseEntryId),
      setType: Value(setType),
      orderIndex: Value(orderIndex),
      reps: Value(reps),
      originalWeightValue: originalWeightValue == null && nullToAbsent
          ? const Value.absent()
          : Value(originalWeightValue),
      originalWeightUnit: originalWeightUnit == null && nullToAbsent
          ? const Value.absent()
          : Value(originalWeightUnit),
      canonicalWeightKilograms: canonicalWeightKilograms == null && nullToAbsent
          ? const Value.absent()
          : Value(canonicalWeightKilograms),
      rpe: rpe == null && nullToAbsent ? const Value.absent() : Value(rpe),
      tempo: tempo == null && nullToAbsent
          ? const Value.absent()
          : Value(tempo),
      restSeconds: restSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(restSeconds),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SetEntriesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SetEntriesTableData(
      id: serializer.fromJson<String>(json['id']),
      exerciseEntryId: serializer.fromJson<String>(json['exerciseEntryId']),
      setType: $SetEntriesTableTable.$convertersetType.fromJson(
        serializer.fromJson<String>(json['setType']),
      ),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
      reps: serializer.fromJson<int>(json['reps']),
      originalWeightValue: serializer.fromJson<double?>(
        json['originalWeightValue'],
      ),
      originalWeightUnit: $SetEntriesTableTable.$converteroriginalWeightUnitn
          .fromJson(serializer.fromJson<String?>(json['originalWeightUnit'])),
      canonicalWeightKilograms: serializer.fromJson<double?>(
        json['canonicalWeightKilograms'],
      ),
      rpe: serializer.fromJson<double?>(json['rpe']),
      tempo: serializer.fromJson<String?>(json['tempo']),
      restSeconds: serializer.fromJson<int?>(json['restSeconds']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'exerciseEntryId': serializer.toJson<String>(exerciseEntryId),
      'setType': serializer.toJson<String>(
        $SetEntriesTableTable.$convertersetType.toJson(setType),
      ),
      'orderIndex': serializer.toJson<int>(orderIndex),
      'reps': serializer.toJson<int>(reps),
      'originalWeightValue': serializer.toJson<double?>(originalWeightValue),
      'originalWeightUnit': serializer.toJson<String?>(
        $SetEntriesTableTable.$converteroriginalWeightUnitn.toJson(
          originalWeightUnit,
        ),
      ),
      'canonicalWeightKilograms': serializer.toJson<double?>(
        canonicalWeightKilograms,
      ),
      'rpe': serializer.toJson<double?>(rpe),
      'tempo': serializer.toJson<String?>(tempo),
      'restSeconds': serializer.toJson<int?>(restSeconds),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SetEntriesTableData copyWith({
    String? id,
    String? exerciseEntryId,
    SetType? setType,
    int? orderIndex,
    int? reps,
    Value<double?> originalWeightValue = const Value.absent(),
    Value<WeightUnit?> originalWeightUnit = const Value.absent(),
    Value<double?> canonicalWeightKilograms = const Value.absent(),
    Value<double?> rpe = const Value.absent(),
    Value<String?> tempo = const Value.absent(),
    Value<int?> restSeconds = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => SetEntriesTableData(
    id: id ?? this.id,
    exerciseEntryId: exerciseEntryId ?? this.exerciseEntryId,
    setType: setType ?? this.setType,
    orderIndex: orderIndex ?? this.orderIndex,
    reps: reps ?? this.reps,
    originalWeightValue: originalWeightValue.present
        ? originalWeightValue.value
        : this.originalWeightValue,
    originalWeightUnit: originalWeightUnit.present
        ? originalWeightUnit.value
        : this.originalWeightUnit,
    canonicalWeightKilograms: canonicalWeightKilograms.present
        ? canonicalWeightKilograms.value
        : this.canonicalWeightKilograms,
    rpe: rpe.present ? rpe.value : this.rpe,
    tempo: tempo.present ? tempo.value : this.tempo,
    restSeconds: restSeconds.present ? restSeconds.value : this.restSeconds,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SetEntriesTableData copyWithCompanion(SetEntriesTableCompanion data) {
    return SetEntriesTableData(
      id: data.id.present ? data.id.value : this.id,
      exerciseEntryId: data.exerciseEntryId.present
          ? data.exerciseEntryId.value
          : this.exerciseEntryId,
      setType: data.setType.present ? data.setType.value : this.setType,
      orderIndex: data.orderIndex.present
          ? data.orderIndex.value
          : this.orderIndex,
      reps: data.reps.present ? data.reps.value : this.reps,
      originalWeightValue: data.originalWeightValue.present
          ? data.originalWeightValue.value
          : this.originalWeightValue,
      originalWeightUnit: data.originalWeightUnit.present
          ? data.originalWeightUnit.value
          : this.originalWeightUnit,
      canonicalWeightKilograms: data.canonicalWeightKilograms.present
          ? data.canonicalWeightKilograms.value
          : this.canonicalWeightKilograms,
      rpe: data.rpe.present ? data.rpe.value : this.rpe,
      tempo: data.tempo.present ? data.tempo.value : this.tempo,
      restSeconds: data.restSeconds.present
          ? data.restSeconds.value
          : this.restSeconds,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SetEntriesTableData(')
          ..write('id: $id, ')
          ..write('exerciseEntryId: $exerciseEntryId, ')
          ..write('setType: $setType, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('reps: $reps, ')
          ..write('originalWeightValue: $originalWeightValue, ')
          ..write('originalWeightUnit: $originalWeightUnit, ')
          ..write('canonicalWeightKilograms: $canonicalWeightKilograms, ')
          ..write('rpe: $rpe, ')
          ..write('tempo: $tempo, ')
          ..write('restSeconds: $restSeconds, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    exerciseEntryId,
    setType,
    orderIndex,
    reps,
    originalWeightValue,
    originalWeightUnit,
    canonicalWeightKilograms,
    rpe,
    tempo,
    restSeconds,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SetEntriesTableData &&
          other.id == this.id &&
          other.exerciseEntryId == this.exerciseEntryId &&
          other.setType == this.setType &&
          other.orderIndex == this.orderIndex &&
          other.reps == this.reps &&
          other.originalWeightValue == this.originalWeightValue &&
          other.originalWeightUnit == this.originalWeightUnit &&
          other.canonicalWeightKilograms == this.canonicalWeightKilograms &&
          other.rpe == this.rpe &&
          other.tempo == this.tempo &&
          other.restSeconds == this.restSeconds &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SetEntriesTableCompanion extends UpdateCompanion<SetEntriesTableData> {
  final Value<String> id;
  final Value<String> exerciseEntryId;
  final Value<SetType> setType;
  final Value<int> orderIndex;
  final Value<int> reps;
  final Value<double?> originalWeightValue;
  final Value<WeightUnit?> originalWeightUnit;
  final Value<double?> canonicalWeightKilograms;
  final Value<double?> rpe;
  final Value<String?> tempo;
  final Value<int?> restSeconds;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SetEntriesTableCompanion({
    this.id = const Value.absent(),
    this.exerciseEntryId = const Value.absent(),
    this.setType = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.reps = const Value.absent(),
    this.originalWeightValue = const Value.absent(),
    this.originalWeightUnit = const Value.absent(),
    this.canonicalWeightKilograms = const Value.absent(),
    this.rpe = const Value.absent(),
    this.tempo = const Value.absent(),
    this.restSeconds = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SetEntriesTableCompanion.insert({
    required String id,
    required String exerciseEntryId,
    required SetType setType,
    required int orderIndex,
    required int reps,
    this.originalWeightValue = const Value.absent(),
    this.originalWeightUnit = const Value.absent(),
    this.canonicalWeightKilograms = const Value.absent(),
    this.rpe = const Value.absent(),
    this.tempo = const Value.absent(),
    this.restSeconds = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       exerciseEntryId = Value(exerciseEntryId),
       setType = Value(setType),
       orderIndex = Value(orderIndex),
       reps = Value(reps),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<SetEntriesTableData> custom({
    Expression<String>? id,
    Expression<String>? exerciseEntryId,
    Expression<String>? setType,
    Expression<int>? orderIndex,
    Expression<int>? reps,
    Expression<double>? originalWeightValue,
    Expression<String>? originalWeightUnit,
    Expression<double>? canonicalWeightKilograms,
    Expression<double>? rpe,
    Expression<String>? tempo,
    Expression<int>? restSeconds,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (exerciseEntryId != null) 'exercise_entry_id': exerciseEntryId,
      if (setType != null) 'set_type': setType,
      if (orderIndex != null) 'order_index': orderIndex,
      if (reps != null) 'reps': reps,
      if (originalWeightValue != null)
        'original_weight_value': originalWeightValue,
      if (originalWeightUnit != null)
        'original_weight_unit': originalWeightUnit,
      if (canonicalWeightKilograms != null)
        'canonical_weight_kilograms': canonicalWeightKilograms,
      if (rpe != null) 'rpe': rpe,
      if (tempo != null) 'tempo': tempo,
      if (restSeconds != null) 'rest_seconds': restSeconds,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SetEntriesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? exerciseEntryId,
    Value<SetType>? setType,
    Value<int>? orderIndex,
    Value<int>? reps,
    Value<double?>? originalWeightValue,
    Value<WeightUnit?>? originalWeightUnit,
    Value<double?>? canonicalWeightKilograms,
    Value<double?>? rpe,
    Value<String?>? tempo,
    Value<int?>? restSeconds,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SetEntriesTableCompanion(
      id: id ?? this.id,
      exerciseEntryId: exerciseEntryId ?? this.exerciseEntryId,
      setType: setType ?? this.setType,
      orderIndex: orderIndex ?? this.orderIndex,
      reps: reps ?? this.reps,
      originalWeightValue: originalWeightValue ?? this.originalWeightValue,
      originalWeightUnit: originalWeightUnit ?? this.originalWeightUnit,
      canonicalWeightKilograms:
          canonicalWeightKilograms ?? this.canonicalWeightKilograms,
      rpe: rpe ?? this.rpe,
      tempo: tempo ?? this.tempo,
      restSeconds: restSeconds ?? this.restSeconds,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (exerciseEntryId.present) {
      map['exercise_entry_id'] = Variable<String>(exerciseEntryId.value);
    }
    if (setType.present) {
      map['set_type'] = Variable<String>(
        $SetEntriesTableTable.$convertersetType.toSql(setType.value),
      );
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (originalWeightValue.present) {
      map['original_weight_value'] = Variable<double>(
        originalWeightValue.value,
      );
    }
    if (originalWeightUnit.present) {
      map['original_weight_unit'] = Variable<String>(
        $SetEntriesTableTable.$converteroriginalWeightUnitn.toSql(
          originalWeightUnit.value,
        ),
      );
    }
    if (canonicalWeightKilograms.present) {
      map['canonical_weight_kilograms'] = Variable<double>(
        canonicalWeightKilograms.value,
      );
    }
    if (rpe.present) {
      map['rpe'] = Variable<double>(rpe.value);
    }
    if (tempo.present) {
      map['tempo'] = Variable<String>(tempo.value);
    }
    if (restSeconds.present) {
      map['rest_seconds'] = Variable<int>(restSeconds.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SetEntriesTableCompanion(')
          ..write('id: $id, ')
          ..write('exerciseEntryId: $exerciseEntryId, ')
          ..write('setType: $setType, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('reps: $reps, ')
          ..write('originalWeightValue: $originalWeightValue, ')
          ..write('originalWeightUnit: $originalWeightUnit, ')
          ..write('canonicalWeightKilograms: $canonicalWeightKilograms, ')
          ..write('rpe: $rpe, ')
          ..write('tempo: $tempo, ')
          ..write('restSeconds: $restSeconds, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BodyLogsTableTable extends BodyLogsTable
    with TableInfo<$BodyLogsTableTable, BodyLogsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BodyLogsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _loggedAtMeta = const VerificationMeta(
    'loggedAt',
  );
  @override
  late final GeneratedColumn<DateTime> loggedAt = GeneratedColumn<DateTime>(
    'logged_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _originalWeightValueMeta =
      const VerificationMeta('originalWeightValue');
  @override
  late final GeneratedColumn<double> originalWeightValue =
      GeneratedColumn<double>(
        'original_weight_value',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  @override
  late final GeneratedColumnWithTypeConverter<WeightUnit?, String>
  originalWeightUnit =
      GeneratedColumn<String>(
        'original_weight_unit',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<WeightUnit?>(
        $BodyLogsTableTable.$converteroriginalWeightUnitn,
      );
  static const VerificationMeta _canonicalWeightKilogramsMeta =
      const VerificationMeta('canonicalWeightKilograms');
  @override
  late final GeneratedColumn<double> canonicalWeightKilograms =
      GeneratedColumn<double>(
        'canonical_weight_kilograms',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _bodyFatPercentageMeta = const VerificationMeta(
    'bodyFatPercentage',
  );
  @override
  late final GeneratedColumn<double> bodyFatPercentage =
      GeneratedColumn<double>(
        'body_fat_percentage',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _originalWaistValueMeta =
      const VerificationMeta('originalWaistValue');
  @override
  late final GeneratedColumn<double> originalWaistValue =
      GeneratedColumn<double>(
        'original_waist_value',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  @override
  late final GeneratedColumnWithTypeConverter<BodyMetricUnit?, String>
  originalWaistUnit =
      GeneratedColumn<String>(
        'original_waist_unit',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<BodyMetricUnit?>(
        $BodyLogsTableTable.$converteroriginalWaistUnitn,
      );
  static const VerificationMeta _canonicalWaistCentimetersMeta =
      const VerificationMeta('canonicalWaistCentimeters');
  @override
  late final GeneratedColumn<double> canonicalWaistCentimeters =
      GeneratedColumn<double>(
        'canonical_waist_centimeters',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    loggedAt,
    originalWeightValue,
    originalWeightUnit,
    canonicalWeightKilograms,
    bodyFatPercentage,
    originalWaistValue,
    originalWaistUnit,
    canonicalWaistCentimeters,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'body_logs_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<BodyLogsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('logged_at')) {
      context.handle(
        _loggedAtMeta,
        loggedAt.isAcceptableOrUnknown(data['logged_at']!, _loggedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_loggedAtMeta);
    }
    if (data.containsKey('original_weight_value')) {
      context.handle(
        _originalWeightValueMeta,
        originalWeightValue.isAcceptableOrUnknown(
          data['original_weight_value']!,
          _originalWeightValueMeta,
        ),
      );
    }
    if (data.containsKey('canonical_weight_kilograms')) {
      context.handle(
        _canonicalWeightKilogramsMeta,
        canonicalWeightKilograms.isAcceptableOrUnknown(
          data['canonical_weight_kilograms']!,
          _canonicalWeightKilogramsMeta,
        ),
      );
    }
    if (data.containsKey('body_fat_percentage')) {
      context.handle(
        _bodyFatPercentageMeta,
        bodyFatPercentage.isAcceptableOrUnknown(
          data['body_fat_percentage']!,
          _bodyFatPercentageMeta,
        ),
      );
    }
    if (data.containsKey('original_waist_value')) {
      context.handle(
        _originalWaistValueMeta,
        originalWaistValue.isAcceptableOrUnknown(
          data['original_waist_value']!,
          _originalWaistValueMeta,
        ),
      );
    }
    if (data.containsKey('canonical_waist_centimeters')) {
      context.handle(
        _canonicalWaistCentimetersMeta,
        canonicalWaistCentimeters.isAcceptableOrUnknown(
          data['canonical_waist_centimeters']!,
          _canonicalWaistCentimetersMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BodyLogsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BodyLogsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      loggedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}logged_at'],
      )!,
      originalWeightValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}original_weight_value'],
      ),
      originalWeightUnit: $BodyLogsTableTable.$converteroriginalWeightUnitn
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}original_weight_unit'],
            ),
          ),
      canonicalWeightKilograms: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}canonical_weight_kilograms'],
      ),
      bodyFatPercentage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}body_fat_percentage'],
      ),
      originalWaistValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}original_waist_value'],
      ),
      originalWaistUnit: $BodyLogsTableTable.$converteroriginalWaistUnitn
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}original_waist_unit'],
            ),
          ),
      canonicalWaistCentimeters: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}canonical_waist_centimeters'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $BodyLogsTableTable createAlias(String alias) {
    return $BodyLogsTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<WeightUnit, String, String>
  $converteroriginalWeightUnit = const EnumNameConverter<WeightUnit>(
    WeightUnit.values,
  );
  static JsonTypeConverter2<WeightUnit?, String?, String?>
  $converteroriginalWeightUnitn = JsonTypeConverter2.asNullable(
    $converteroriginalWeightUnit,
  );
  static JsonTypeConverter2<BodyMetricUnit, String, String>
  $converteroriginalWaistUnit = const EnumNameConverter<BodyMetricUnit>(
    BodyMetricUnit.values,
  );
  static JsonTypeConverter2<BodyMetricUnit?, String?, String?>
  $converteroriginalWaistUnitn = JsonTypeConverter2.asNullable(
    $converteroriginalWaistUnit,
  );
}

class BodyLogsTableData extends DataClass
    implements Insertable<BodyLogsTableData> {
  final String id;
  final DateTime loggedAt;
  final double? originalWeightValue;
  final WeightUnit? originalWeightUnit;
  final double? canonicalWeightKilograms;
  final double? bodyFatPercentage;
  final double? originalWaistValue;
  final BodyMetricUnit? originalWaistUnit;
  final double? canonicalWaistCentimeters;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const BodyLogsTableData({
    required this.id,
    required this.loggedAt,
    this.originalWeightValue,
    this.originalWeightUnit,
    this.canonicalWeightKilograms,
    this.bodyFatPercentage,
    this.originalWaistValue,
    this.originalWaistUnit,
    this.canonicalWaistCentimeters,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['logged_at'] = Variable<DateTime>(loggedAt);
    if (!nullToAbsent || originalWeightValue != null) {
      map['original_weight_value'] = Variable<double>(originalWeightValue);
    }
    if (!nullToAbsent || originalWeightUnit != null) {
      map['original_weight_unit'] = Variable<String>(
        $BodyLogsTableTable.$converteroriginalWeightUnitn.toSql(
          originalWeightUnit,
        ),
      );
    }
    if (!nullToAbsent || canonicalWeightKilograms != null) {
      map['canonical_weight_kilograms'] = Variable<double>(
        canonicalWeightKilograms,
      );
    }
    if (!nullToAbsent || bodyFatPercentage != null) {
      map['body_fat_percentage'] = Variable<double>(bodyFatPercentage);
    }
    if (!nullToAbsent || originalWaistValue != null) {
      map['original_waist_value'] = Variable<double>(originalWaistValue);
    }
    if (!nullToAbsent || originalWaistUnit != null) {
      map['original_waist_unit'] = Variable<String>(
        $BodyLogsTableTable.$converteroriginalWaistUnitn.toSql(
          originalWaistUnit,
        ),
      );
    }
    if (!nullToAbsent || canonicalWaistCentimeters != null) {
      map['canonical_waist_centimeters'] = Variable<double>(
        canonicalWaistCentimeters,
      );
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BodyLogsTableCompanion toCompanion(bool nullToAbsent) {
    return BodyLogsTableCompanion(
      id: Value(id),
      loggedAt: Value(loggedAt),
      originalWeightValue: originalWeightValue == null && nullToAbsent
          ? const Value.absent()
          : Value(originalWeightValue),
      originalWeightUnit: originalWeightUnit == null && nullToAbsent
          ? const Value.absent()
          : Value(originalWeightUnit),
      canonicalWeightKilograms: canonicalWeightKilograms == null && nullToAbsent
          ? const Value.absent()
          : Value(canonicalWeightKilograms),
      bodyFatPercentage: bodyFatPercentage == null && nullToAbsent
          ? const Value.absent()
          : Value(bodyFatPercentage),
      originalWaistValue: originalWaistValue == null && nullToAbsent
          ? const Value.absent()
          : Value(originalWaistValue),
      originalWaistUnit: originalWaistUnit == null && nullToAbsent
          ? const Value.absent()
          : Value(originalWaistUnit),
      canonicalWaistCentimeters:
          canonicalWaistCentimeters == null && nullToAbsent
          ? const Value.absent()
          : Value(canonicalWaistCentimeters),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory BodyLogsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BodyLogsTableData(
      id: serializer.fromJson<String>(json['id']),
      loggedAt: serializer.fromJson<DateTime>(json['loggedAt']),
      originalWeightValue: serializer.fromJson<double?>(
        json['originalWeightValue'],
      ),
      originalWeightUnit: $BodyLogsTableTable.$converteroriginalWeightUnitn
          .fromJson(serializer.fromJson<String?>(json['originalWeightUnit'])),
      canonicalWeightKilograms: serializer.fromJson<double?>(
        json['canonicalWeightKilograms'],
      ),
      bodyFatPercentage: serializer.fromJson<double?>(
        json['bodyFatPercentage'],
      ),
      originalWaistValue: serializer.fromJson<double?>(
        json['originalWaistValue'],
      ),
      originalWaistUnit: $BodyLogsTableTable.$converteroriginalWaistUnitn
          .fromJson(serializer.fromJson<String?>(json['originalWaistUnit'])),
      canonicalWaistCentimeters: serializer.fromJson<double?>(
        json['canonicalWaistCentimeters'],
      ),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'loggedAt': serializer.toJson<DateTime>(loggedAt),
      'originalWeightValue': serializer.toJson<double?>(originalWeightValue),
      'originalWeightUnit': serializer.toJson<String?>(
        $BodyLogsTableTable.$converteroriginalWeightUnitn.toJson(
          originalWeightUnit,
        ),
      ),
      'canonicalWeightKilograms': serializer.toJson<double?>(
        canonicalWeightKilograms,
      ),
      'bodyFatPercentage': serializer.toJson<double?>(bodyFatPercentage),
      'originalWaistValue': serializer.toJson<double?>(originalWaistValue),
      'originalWaistUnit': serializer.toJson<String?>(
        $BodyLogsTableTable.$converteroriginalWaistUnitn.toJson(
          originalWaistUnit,
        ),
      ),
      'canonicalWaistCentimeters': serializer.toJson<double?>(
        canonicalWaistCentimeters,
      ),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  BodyLogsTableData copyWith({
    String? id,
    DateTime? loggedAt,
    Value<double?> originalWeightValue = const Value.absent(),
    Value<WeightUnit?> originalWeightUnit = const Value.absent(),
    Value<double?> canonicalWeightKilograms = const Value.absent(),
    Value<double?> bodyFatPercentage = const Value.absent(),
    Value<double?> originalWaistValue = const Value.absent(),
    Value<BodyMetricUnit?> originalWaistUnit = const Value.absent(),
    Value<double?> canonicalWaistCentimeters = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => BodyLogsTableData(
    id: id ?? this.id,
    loggedAt: loggedAt ?? this.loggedAt,
    originalWeightValue: originalWeightValue.present
        ? originalWeightValue.value
        : this.originalWeightValue,
    originalWeightUnit: originalWeightUnit.present
        ? originalWeightUnit.value
        : this.originalWeightUnit,
    canonicalWeightKilograms: canonicalWeightKilograms.present
        ? canonicalWeightKilograms.value
        : this.canonicalWeightKilograms,
    bodyFatPercentage: bodyFatPercentage.present
        ? bodyFatPercentage.value
        : this.bodyFatPercentage,
    originalWaistValue: originalWaistValue.present
        ? originalWaistValue.value
        : this.originalWaistValue,
    originalWaistUnit: originalWaistUnit.present
        ? originalWaistUnit.value
        : this.originalWaistUnit,
    canonicalWaistCentimeters: canonicalWaistCentimeters.present
        ? canonicalWaistCentimeters.value
        : this.canonicalWaistCentimeters,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  BodyLogsTableData copyWithCompanion(BodyLogsTableCompanion data) {
    return BodyLogsTableData(
      id: data.id.present ? data.id.value : this.id,
      loggedAt: data.loggedAt.present ? data.loggedAt.value : this.loggedAt,
      originalWeightValue: data.originalWeightValue.present
          ? data.originalWeightValue.value
          : this.originalWeightValue,
      originalWeightUnit: data.originalWeightUnit.present
          ? data.originalWeightUnit.value
          : this.originalWeightUnit,
      canonicalWeightKilograms: data.canonicalWeightKilograms.present
          ? data.canonicalWeightKilograms.value
          : this.canonicalWeightKilograms,
      bodyFatPercentage: data.bodyFatPercentage.present
          ? data.bodyFatPercentage.value
          : this.bodyFatPercentage,
      originalWaistValue: data.originalWaistValue.present
          ? data.originalWaistValue.value
          : this.originalWaistValue,
      originalWaistUnit: data.originalWaistUnit.present
          ? data.originalWaistUnit.value
          : this.originalWaistUnit,
      canonicalWaistCentimeters: data.canonicalWaistCentimeters.present
          ? data.canonicalWaistCentimeters.value
          : this.canonicalWaistCentimeters,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BodyLogsTableData(')
          ..write('id: $id, ')
          ..write('loggedAt: $loggedAt, ')
          ..write('originalWeightValue: $originalWeightValue, ')
          ..write('originalWeightUnit: $originalWeightUnit, ')
          ..write('canonicalWeightKilograms: $canonicalWeightKilograms, ')
          ..write('bodyFatPercentage: $bodyFatPercentage, ')
          ..write('originalWaistValue: $originalWaistValue, ')
          ..write('originalWaistUnit: $originalWaistUnit, ')
          ..write('canonicalWaistCentimeters: $canonicalWaistCentimeters, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    loggedAt,
    originalWeightValue,
    originalWeightUnit,
    canonicalWeightKilograms,
    bodyFatPercentage,
    originalWaistValue,
    originalWaistUnit,
    canonicalWaistCentimeters,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BodyLogsTableData &&
          other.id == this.id &&
          other.loggedAt == this.loggedAt &&
          other.originalWeightValue == this.originalWeightValue &&
          other.originalWeightUnit == this.originalWeightUnit &&
          other.canonicalWeightKilograms == this.canonicalWeightKilograms &&
          other.bodyFatPercentage == this.bodyFatPercentage &&
          other.originalWaistValue == this.originalWaistValue &&
          other.originalWaistUnit == this.originalWaistUnit &&
          other.canonicalWaistCentimeters == this.canonicalWaistCentimeters &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BodyLogsTableCompanion extends UpdateCompanion<BodyLogsTableData> {
  final Value<String> id;
  final Value<DateTime> loggedAt;
  final Value<double?> originalWeightValue;
  final Value<WeightUnit?> originalWeightUnit;
  final Value<double?> canonicalWeightKilograms;
  final Value<double?> bodyFatPercentage;
  final Value<double?> originalWaistValue;
  final Value<BodyMetricUnit?> originalWaistUnit;
  final Value<double?> canonicalWaistCentimeters;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const BodyLogsTableCompanion({
    this.id = const Value.absent(),
    this.loggedAt = const Value.absent(),
    this.originalWeightValue = const Value.absent(),
    this.originalWeightUnit = const Value.absent(),
    this.canonicalWeightKilograms = const Value.absent(),
    this.bodyFatPercentage = const Value.absent(),
    this.originalWaistValue = const Value.absent(),
    this.originalWaistUnit = const Value.absent(),
    this.canonicalWaistCentimeters = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BodyLogsTableCompanion.insert({
    required String id,
    required DateTime loggedAt,
    this.originalWeightValue = const Value.absent(),
    this.originalWeightUnit = const Value.absent(),
    this.canonicalWeightKilograms = const Value.absent(),
    this.bodyFatPercentage = const Value.absent(),
    this.originalWaistValue = const Value.absent(),
    this.originalWaistUnit = const Value.absent(),
    this.canonicalWaistCentimeters = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       loggedAt = Value(loggedAt),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<BodyLogsTableData> custom({
    Expression<String>? id,
    Expression<DateTime>? loggedAt,
    Expression<double>? originalWeightValue,
    Expression<String>? originalWeightUnit,
    Expression<double>? canonicalWeightKilograms,
    Expression<double>? bodyFatPercentage,
    Expression<double>? originalWaistValue,
    Expression<String>? originalWaistUnit,
    Expression<double>? canonicalWaistCentimeters,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (loggedAt != null) 'logged_at': loggedAt,
      if (originalWeightValue != null)
        'original_weight_value': originalWeightValue,
      if (originalWeightUnit != null)
        'original_weight_unit': originalWeightUnit,
      if (canonicalWeightKilograms != null)
        'canonical_weight_kilograms': canonicalWeightKilograms,
      if (bodyFatPercentage != null) 'body_fat_percentage': bodyFatPercentage,
      if (originalWaistValue != null)
        'original_waist_value': originalWaistValue,
      if (originalWaistUnit != null) 'original_waist_unit': originalWaistUnit,
      if (canonicalWaistCentimeters != null)
        'canonical_waist_centimeters': canonicalWaistCentimeters,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BodyLogsTableCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? loggedAt,
    Value<double?>? originalWeightValue,
    Value<WeightUnit?>? originalWeightUnit,
    Value<double?>? canonicalWeightKilograms,
    Value<double?>? bodyFatPercentage,
    Value<double?>? originalWaistValue,
    Value<BodyMetricUnit?>? originalWaistUnit,
    Value<double?>? canonicalWaistCentimeters,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return BodyLogsTableCompanion(
      id: id ?? this.id,
      loggedAt: loggedAt ?? this.loggedAt,
      originalWeightValue: originalWeightValue ?? this.originalWeightValue,
      originalWeightUnit: originalWeightUnit ?? this.originalWeightUnit,
      canonicalWeightKilograms:
          canonicalWeightKilograms ?? this.canonicalWeightKilograms,
      bodyFatPercentage: bodyFatPercentage ?? this.bodyFatPercentage,
      originalWaistValue: originalWaistValue ?? this.originalWaistValue,
      originalWaistUnit: originalWaistUnit ?? this.originalWaistUnit,
      canonicalWaistCentimeters:
          canonicalWaistCentimeters ?? this.canonicalWaistCentimeters,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (loggedAt.present) {
      map['logged_at'] = Variable<DateTime>(loggedAt.value);
    }
    if (originalWeightValue.present) {
      map['original_weight_value'] = Variable<double>(
        originalWeightValue.value,
      );
    }
    if (originalWeightUnit.present) {
      map['original_weight_unit'] = Variable<String>(
        $BodyLogsTableTable.$converteroriginalWeightUnitn.toSql(
          originalWeightUnit.value,
        ),
      );
    }
    if (canonicalWeightKilograms.present) {
      map['canonical_weight_kilograms'] = Variable<double>(
        canonicalWeightKilograms.value,
      );
    }
    if (bodyFatPercentage.present) {
      map['body_fat_percentage'] = Variable<double>(bodyFatPercentage.value);
    }
    if (originalWaistValue.present) {
      map['original_waist_value'] = Variable<double>(originalWaistValue.value);
    }
    if (originalWaistUnit.present) {
      map['original_waist_unit'] = Variable<String>(
        $BodyLogsTableTable.$converteroriginalWaistUnitn.toSql(
          originalWaistUnit.value,
        ),
      );
    }
    if (canonicalWaistCentimeters.present) {
      map['canonical_waist_centimeters'] = Variable<double>(
        canonicalWaistCentimeters.value,
      );
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BodyLogsTableCompanion(')
          ..write('id: $id, ')
          ..write('loggedAt: $loggedAt, ')
          ..write('originalWeightValue: $originalWeightValue, ')
          ..write('originalWeightUnit: $originalWeightUnit, ')
          ..write('canonicalWeightKilograms: $canonicalWeightKilograms, ')
          ..write('bodyFatPercentage: $bodyFatPercentage, ')
          ..write('originalWaistValue: $originalWaistValue, ')
          ..write('originalWaistUnit: $originalWaistUnit, ')
          ..write('canonicalWaistCentimeters: $canonicalWaistCentimeters, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FoodsTableTable extends FoodsTable
    with TableInfo<$FoodsTableTable, FoodsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoodsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 160,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _brandNameMeta = const VerificationMeta(
    'brandName',
  );
  @override
  late final GeneratedColumn<String> brandName = GeneratedColumn<String>(
    'brand_name',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _barcodeMeta = const VerificationMeta(
    'barcode',
  );
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
    'barcode',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _caloriesPer100gMeta = const VerificationMeta(
    'caloriesPer100g',
  );
  @override
  late final GeneratedColumn<int> caloriesPer100g = GeneratedColumn<int>(
    'calories_per100g',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proteinPer100gMeta = const VerificationMeta(
    'proteinPer100g',
  );
  @override
  late final GeneratedColumn<double> proteinPer100g = GeneratedColumn<double>(
    'protein_per100g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _carbsPer100gMeta = const VerificationMeta(
    'carbsPer100g',
  );
  @override
  late final GeneratedColumn<double> carbsPer100g = GeneratedColumn<double>(
    'carbs_per100g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fatPer100gMeta = const VerificationMeta(
    'fatPer100g',
  );
  @override
  late final GeneratedColumn<double> fatPer100g = GeneratedColumn<double>(
    'fat_per100g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SyncSource, String> source =
      GeneratedColumn<String>(
        'source',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<SyncSource>($FoodsTableTable.$convertersource);
  static const VerificationMeta _isUserEditedMeta = const VerificationMeta(
    'isUserEdited',
  );
  @override
  late final GeneratedColumn<bool> isUserEdited = GeneratedColumn<bool>(
    'is_user_edited',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_user_edited" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    brandName,
    barcode,
    caloriesPer100g,
    proteinPer100g,
    carbsPer100g,
    fatPer100g,
    source,
    isUserEdited,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'foods_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<FoodsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('brand_name')) {
      context.handle(
        _brandNameMeta,
        brandName.isAcceptableOrUnknown(data['brand_name']!, _brandNameMeta),
      );
    }
    if (data.containsKey('barcode')) {
      context.handle(
        _barcodeMeta,
        barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta),
      );
    }
    if (data.containsKey('calories_per100g')) {
      context.handle(
        _caloriesPer100gMeta,
        caloriesPer100g.isAcceptableOrUnknown(
          data['calories_per100g']!,
          _caloriesPer100gMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_caloriesPer100gMeta);
    }
    if (data.containsKey('protein_per100g')) {
      context.handle(
        _proteinPer100gMeta,
        proteinPer100g.isAcceptableOrUnknown(
          data['protein_per100g']!,
          _proteinPer100gMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_proteinPer100gMeta);
    }
    if (data.containsKey('carbs_per100g')) {
      context.handle(
        _carbsPer100gMeta,
        carbsPer100g.isAcceptableOrUnknown(
          data['carbs_per100g']!,
          _carbsPer100gMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_carbsPer100gMeta);
    }
    if (data.containsKey('fat_per100g')) {
      context.handle(
        _fatPer100gMeta,
        fatPer100g.isAcceptableOrUnknown(data['fat_per100g']!, _fatPer100gMeta),
      );
    } else if (isInserting) {
      context.missing(_fatPer100gMeta);
    }
    if (data.containsKey('is_user_edited')) {
      context.handle(
        _isUserEditedMeta,
        isUserEdited.isAcceptableOrUnknown(
          data['is_user_edited']!,
          _isUserEditedMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FoodsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FoodsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      brandName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brand_name'],
      ),
      barcode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}barcode'],
      ),
      caloriesPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}calories_per100g'],
      )!,
      proteinPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein_per100g'],
      )!,
      carbsPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carbs_per100g'],
      )!,
      fatPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fat_per100g'],
      )!,
      source: $FoodsTableTable.$convertersource.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}source'],
        )!,
      ),
      isUserEdited: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_user_edited'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $FoodsTableTable createAlias(String alias) {
    return $FoodsTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SyncSource, String, String> $convertersource =
      const EnumNameConverter<SyncSource>(SyncSource.values);
}

class FoodsTableData extends DataClass implements Insertable<FoodsTableData> {
  final String id;
  final String name;
  final String? brandName;
  final String? barcode;
  final int caloriesPer100g;
  final double proteinPer100g;
  final double carbsPer100g;
  final double fatPer100g;
  final SyncSource source;
  final bool isUserEdited;
  final DateTime createdAt;
  final DateTime updatedAt;
  const FoodsTableData({
    required this.id,
    required this.name,
    this.brandName,
    this.barcode,
    required this.caloriesPer100g,
    required this.proteinPer100g,
    required this.carbsPer100g,
    required this.fatPer100g,
    required this.source,
    required this.isUserEdited,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || brandName != null) {
      map['brand_name'] = Variable<String>(brandName);
    }
    if (!nullToAbsent || barcode != null) {
      map['barcode'] = Variable<String>(barcode);
    }
    map['calories_per100g'] = Variable<int>(caloriesPer100g);
    map['protein_per100g'] = Variable<double>(proteinPer100g);
    map['carbs_per100g'] = Variable<double>(carbsPer100g);
    map['fat_per100g'] = Variable<double>(fatPer100g);
    {
      map['source'] = Variable<String>(
        $FoodsTableTable.$convertersource.toSql(source),
      );
    }
    map['is_user_edited'] = Variable<bool>(isUserEdited);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FoodsTableCompanion toCompanion(bool nullToAbsent) {
    return FoodsTableCompanion(
      id: Value(id),
      name: Value(name),
      brandName: brandName == null && nullToAbsent
          ? const Value.absent()
          : Value(brandName),
      barcode: barcode == null && nullToAbsent
          ? const Value.absent()
          : Value(barcode),
      caloriesPer100g: Value(caloriesPer100g),
      proteinPer100g: Value(proteinPer100g),
      carbsPer100g: Value(carbsPer100g),
      fatPer100g: Value(fatPer100g),
      source: Value(source),
      isUserEdited: Value(isUserEdited),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory FoodsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FoodsTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      brandName: serializer.fromJson<String?>(json['brandName']),
      barcode: serializer.fromJson<String?>(json['barcode']),
      caloriesPer100g: serializer.fromJson<int>(json['caloriesPer100g']),
      proteinPer100g: serializer.fromJson<double>(json['proteinPer100g']),
      carbsPer100g: serializer.fromJson<double>(json['carbsPer100g']),
      fatPer100g: serializer.fromJson<double>(json['fatPer100g']),
      source: $FoodsTableTable.$convertersource.fromJson(
        serializer.fromJson<String>(json['source']),
      ),
      isUserEdited: serializer.fromJson<bool>(json['isUserEdited']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'brandName': serializer.toJson<String?>(brandName),
      'barcode': serializer.toJson<String?>(barcode),
      'caloriesPer100g': serializer.toJson<int>(caloriesPer100g),
      'proteinPer100g': serializer.toJson<double>(proteinPer100g),
      'carbsPer100g': serializer.toJson<double>(carbsPer100g),
      'fatPer100g': serializer.toJson<double>(fatPer100g),
      'source': serializer.toJson<String>(
        $FoodsTableTable.$convertersource.toJson(source),
      ),
      'isUserEdited': serializer.toJson<bool>(isUserEdited),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  FoodsTableData copyWith({
    String? id,
    String? name,
    Value<String?> brandName = const Value.absent(),
    Value<String?> barcode = const Value.absent(),
    int? caloriesPer100g,
    double? proteinPer100g,
    double? carbsPer100g,
    double? fatPer100g,
    SyncSource? source,
    bool? isUserEdited,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => FoodsTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    brandName: brandName.present ? brandName.value : this.brandName,
    barcode: barcode.present ? barcode.value : this.barcode,
    caloriesPer100g: caloriesPer100g ?? this.caloriesPer100g,
    proteinPer100g: proteinPer100g ?? this.proteinPer100g,
    carbsPer100g: carbsPer100g ?? this.carbsPer100g,
    fatPer100g: fatPer100g ?? this.fatPer100g,
    source: source ?? this.source,
    isUserEdited: isUserEdited ?? this.isUserEdited,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  FoodsTableData copyWithCompanion(FoodsTableCompanion data) {
    return FoodsTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      brandName: data.brandName.present ? data.brandName.value : this.brandName,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      caloriesPer100g: data.caloriesPer100g.present
          ? data.caloriesPer100g.value
          : this.caloriesPer100g,
      proteinPer100g: data.proteinPer100g.present
          ? data.proteinPer100g.value
          : this.proteinPer100g,
      carbsPer100g: data.carbsPer100g.present
          ? data.carbsPer100g.value
          : this.carbsPer100g,
      fatPer100g: data.fatPer100g.present
          ? data.fatPer100g.value
          : this.fatPer100g,
      source: data.source.present ? data.source.value : this.source,
      isUserEdited: data.isUserEdited.present
          ? data.isUserEdited.value
          : this.isUserEdited,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FoodsTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('brandName: $brandName, ')
          ..write('barcode: $barcode, ')
          ..write('caloriesPer100g: $caloriesPer100g, ')
          ..write('proteinPer100g: $proteinPer100g, ')
          ..write('carbsPer100g: $carbsPer100g, ')
          ..write('fatPer100g: $fatPer100g, ')
          ..write('source: $source, ')
          ..write('isUserEdited: $isUserEdited, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    brandName,
    barcode,
    caloriesPer100g,
    proteinPer100g,
    carbsPer100g,
    fatPer100g,
    source,
    isUserEdited,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodsTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.brandName == this.brandName &&
          other.barcode == this.barcode &&
          other.caloriesPer100g == this.caloriesPer100g &&
          other.proteinPer100g == this.proteinPer100g &&
          other.carbsPer100g == this.carbsPer100g &&
          other.fatPer100g == this.fatPer100g &&
          other.source == this.source &&
          other.isUserEdited == this.isUserEdited &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FoodsTableCompanion extends UpdateCompanion<FoodsTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> brandName;
  final Value<String?> barcode;
  final Value<int> caloriesPer100g;
  final Value<double> proteinPer100g;
  final Value<double> carbsPer100g;
  final Value<double> fatPer100g;
  final Value<SyncSource> source;
  final Value<bool> isUserEdited;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const FoodsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.brandName = const Value.absent(),
    this.barcode = const Value.absent(),
    this.caloriesPer100g = const Value.absent(),
    this.proteinPer100g = const Value.absent(),
    this.carbsPer100g = const Value.absent(),
    this.fatPer100g = const Value.absent(),
    this.source = const Value.absent(),
    this.isUserEdited = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FoodsTableCompanion.insert({
    required String id,
    required String name,
    this.brandName = const Value.absent(),
    this.barcode = const Value.absent(),
    required int caloriesPer100g,
    required double proteinPer100g,
    required double carbsPer100g,
    required double fatPer100g,
    required SyncSource source,
    this.isUserEdited = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       caloriesPer100g = Value(caloriesPer100g),
       proteinPer100g = Value(proteinPer100g),
       carbsPer100g = Value(carbsPer100g),
       fatPer100g = Value(fatPer100g),
       source = Value(source),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<FoodsTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? brandName,
    Expression<String>? barcode,
    Expression<int>? caloriesPer100g,
    Expression<double>? proteinPer100g,
    Expression<double>? carbsPer100g,
    Expression<double>? fatPer100g,
    Expression<String>? source,
    Expression<bool>? isUserEdited,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (brandName != null) 'brand_name': brandName,
      if (barcode != null) 'barcode': barcode,
      if (caloriesPer100g != null) 'calories_per100g': caloriesPer100g,
      if (proteinPer100g != null) 'protein_per100g': proteinPer100g,
      if (carbsPer100g != null) 'carbs_per100g': carbsPer100g,
      if (fatPer100g != null) 'fat_per100g': fatPer100g,
      if (source != null) 'source': source,
      if (isUserEdited != null) 'is_user_edited': isUserEdited,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FoodsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? brandName,
    Value<String?>? barcode,
    Value<int>? caloriesPer100g,
    Value<double>? proteinPer100g,
    Value<double>? carbsPer100g,
    Value<double>? fatPer100g,
    Value<SyncSource>? source,
    Value<bool>? isUserEdited,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return FoodsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      brandName: brandName ?? this.brandName,
      barcode: barcode ?? this.barcode,
      caloriesPer100g: caloriesPer100g ?? this.caloriesPer100g,
      proteinPer100g: proteinPer100g ?? this.proteinPer100g,
      carbsPer100g: carbsPer100g ?? this.carbsPer100g,
      fatPer100g: fatPer100g ?? this.fatPer100g,
      source: source ?? this.source,
      isUserEdited: isUserEdited ?? this.isUserEdited,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (brandName.present) {
      map['brand_name'] = Variable<String>(brandName.value);
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (caloriesPer100g.present) {
      map['calories_per100g'] = Variable<int>(caloriesPer100g.value);
    }
    if (proteinPer100g.present) {
      map['protein_per100g'] = Variable<double>(proteinPer100g.value);
    }
    if (carbsPer100g.present) {
      map['carbs_per100g'] = Variable<double>(carbsPer100g.value);
    }
    if (fatPer100g.present) {
      map['fat_per100g'] = Variable<double>(fatPer100g.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(
        $FoodsTableTable.$convertersource.toSql(source.value),
      );
    }
    if (isUserEdited.present) {
      map['is_user_edited'] = Variable<bool>(isUserEdited.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('brandName: $brandName, ')
          ..write('barcode: $barcode, ')
          ..write('caloriesPer100g: $caloriesPer100g, ')
          ..write('proteinPer100g: $proteinPer100g, ')
          ..write('carbsPer100g: $carbsPer100g, ')
          ..write('fatPer100g: $fatPer100g, ')
          ..write('source: $source, ')
          ..write('isUserEdited: $isUserEdited, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FoodPortionsTableTable extends FoodPortionsTable
    with TableInfo<$FoodPortionsTableTable, FoodPortionsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoodPortionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _foodIdMeta = const VerificationMeta('foodId');
  @override
  late final GeneratedColumn<String> foodId = GeneratedColumn<String>(
    'food_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES foods_table (id) ON DELETE CASCADE',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<FoodQuantityUnit, String> unit =
      GeneratedColumn<String>(
        'unit',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<FoodQuantityUnit>($FoodPortionsTableTable.$converterunit);
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referenceAmountMeta = const VerificationMeta(
    'referenceAmount',
  );
  @override
  late final GeneratedColumn<double> referenceAmount = GeneratedColumn<double>(
    'reference_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _canonicalGramsMeta = const VerificationMeta(
    'canonicalGrams',
  );
  @override
  late final GeneratedColumn<double> canonicalGrams = GeneratedColumn<double>(
    'canonical_grams',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _canonicalMillilitersMeta =
      const VerificationMeta('canonicalMilliliters');
  @override
  late final GeneratedColumn<double> canonicalMilliliters =
      GeneratedColumn<double>(
        'canonical_milliliters',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    foodId,
    unit,
    label,
    referenceAmount,
    canonicalGrams,
    canonicalMilliliters,
    sortOrder,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'food_portions_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<FoodPortionsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('food_id')) {
      context.handle(
        _foodIdMeta,
        foodId.isAcceptableOrUnknown(data['food_id']!, _foodIdMeta),
      );
    } else if (isInserting) {
      context.missing(_foodIdMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('reference_amount')) {
      context.handle(
        _referenceAmountMeta,
        referenceAmount.isAcceptableOrUnknown(
          data['reference_amount']!,
          _referenceAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_referenceAmountMeta);
    }
    if (data.containsKey('canonical_grams')) {
      context.handle(
        _canonicalGramsMeta,
        canonicalGrams.isAcceptableOrUnknown(
          data['canonical_grams']!,
          _canonicalGramsMeta,
        ),
      );
    }
    if (data.containsKey('canonical_milliliters')) {
      context.handle(
        _canonicalMillilitersMeta,
        canonicalMilliliters.isAcceptableOrUnknown(
          data['canonical_milliliters']!,
          _canonicalMillilitersMeta,
        ),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FoodPortionsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FoodPortionsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      foodId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}food_id'],
      )!,
      unit: $FoodPortionsTableTable.$converterunit.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}unit'],
        )!,
      ),
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      referenceAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}reference_amount'],
      )!,
      canonicalGrams: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}canonical_grams'],
      ),
      canonicalMilliliters: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}canonical_milliliters'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $FoodPortionsTableTable createAlias(String alias) {
    return $FoodPortionsTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<FoodQuantityUnit, String, String> $converterunit =
      const EnumNameConverter<FoodQuantityUnit>(FoodQuantityUnit.values);
}

class FoodPortionsTableData extends DataClass
    implements Insertable<FoodPortionsTableData> {
  final String id;
  final String foodId;
  final FoodQuantityUnit unit;
  final String label;
  final double referenceAmount;
  final double? canonicalGrams;
  final double? canonicalMilliliters;
  final int sortOrder;
  final DateTime createdAt;
  final DateTime updatedAt;
  const FoodPortionsTableData({
    required this.id,
    required this.foodId,
    required this.unit,
    required this.label,
    required this.referenceAmount,
    this.canonicalGrams,
    this.canonicalMilliliters,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['food_id'] = Variable<String>(foodId);
    {
      map['unit'] = Variable<String>(
        $FoodPortionsTableTable.$converterunit.toSql(unit),
      );
    }
    map['label'] = Variable<String>(label);
    map['reference_amount'] = Variable<double>(referenceAmount);
    if (!nullToAbsent || canonicalGrams != null) {
      map['canonical_grams'] = Variable<double>(canonicalGrams);
    }
    if (!nullToAbsent || canonicalMilliliters != null) {
      map['canonical_milliliters'] = Variable<double>(canonicalMilliliters);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FoodPortionsTableCompanion toCompanion(bool nullToAbsent) {
    return FoodPortionsTableCompanion(
      id: Value(id),
      foodId: Value(foodId),
      unit: Value(unit),
      label: Value(label),
      referenceAmount: Value(referenceAmount),
      canonicalGrams: canonicalGrams == null && nullToAbsent
          ? const Value.absent()
          : Value(canonicalGrams),
      canonicalMilliliters: canonicalMilliliters == null && nullToAbsent
          ? const Value.absent()
          : Value(canonicalMilliliters),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory FoodPortionsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FoodPortionsTableData(
      id: serializer.fromJson<String>(json['id']),
      foodId: serializer.fromJson<String>(json['foodId']),
      unit: $FoodPortionsTableTable.$converterunit.fromJson(
        serializer.fromJson<String>(json['unit']),
      ),
      label: serializer.fromJson<String>(json['label']),
      referenceAmount: serializer.fromJson<double>(json['referenceAmount']),
      canonicalGrams: serializer.fromJson<double?>(json['canonicalGrams']),
      canonicalMilliliters: serializer.fromJson<double?>(
        json['canonicalMilliliters'],
      ),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'foodId': serializer.toJson<String>(foodId),
      'unit': serializer.toJson<String>(
        $FoodPortionsTableTable.$converterunit.toJson(unit),
      ),
      'label': serializer.toJson<String>(label),
      'referenceAmount': serializer.toJson<double>(referenceAmount),
      'canonicalGrams': serializer.toJson<double?>(canonicalGrams),
      'canonicalMilliliters': serializer.toJson<double?>(canonicalMilliliters),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  FoodPortionsTableData copyWith({
    String? id,
    String? foodId,
    FoodQuantityUnit? unit,
    String? label,
    double? referenceAmount,
    Value<double?> canonicalGrams = const Value.absent(),
    Value<double?> canonicalMilliliters = const Value.absent(),
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => FoodPortionsTableData(
    id: id ?? this.id,
    foodId: foodId ?? this.foodId,
    unit: unit ?? this.unit,
    label: label ?? this.label,
    referenceAmount: referenceAmount ?? this.referenceAmount,
    canonicalGrams: canonicalGrams.present
        ? canonicalGrams.value
        : this.canonicalGrams,
    canonicalMilliliters: canonicalMilliliters.present
        ? canonicalMilliliters.value
        : this.canonicalMilliliters,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  FoodPortionsTableData copyWithCompanion(FoodPortionsTableCompanion data) {
    return FoodPortionsTableData(
      id: data.id.present ? data.id.value : this.id,
      foodId: data.foodId.present ? data.foodId.value : this.foodId,
      unit: data.unit.present ? data.unit.value : this.unit,
      label: data.label.present ? data.label.value : this.label,
      referenceAmount: data.referenceAmount.present
          ? data.referenceAmount.value
          : this.referenceAmount,
      canonicalGrams: data.canonicalGrams.present
          ? data.canonicalGrams.value
          : this.canonicalGrams,
      canonicalMilliliters: data.canonicalMilliliters.present
          ? data.canonicalMilliliters.value
          : this.canonicalMilliliters,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FoodPortionsTableData(')
          ..write('id: $id, ')
          ..write('foodId: $foodId, ')
          ..write('unit: $unit, ')
          ..write('label: $label, ')
          ..write('referenceAmount: $referenceAmount, ')
          ..write('canonicalGrams: $canonicalGrams, ')
          ..write('canonicalMilliliters: $canonicalMilliliters, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    foodId,
    unit,
    label,
    referenceAmount,
    canonicalGrams,
    canonicalMilliliters,
    sortOrder,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodPortionsTableData &&
          other.id == this.id &&
          other.foodId == this.foodId &&
          other.unit == this.unit &&
          other.label == this.label &&
          other.referenceAmount == this.referenceAmount &&
          other.canonicalGrams == this.canonicalGrams &&
          other.canonicalMilliliters == this.canonicalMilliliters &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FoodPortionsTableCompanion
    extends UpdateCompanion<FoodPortionsTableData> {
  final Value<String> id;
  final Value<String> foodId;
  final Value<FoodQuantityUnit> unit;
  final Value<String> label;
  final Value<double> referenceAmount;
  final Value<double?> canonicalGrams;
  final Value<double?> canonicalMilliliters;
  final Value<int> sortOrder;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const FoodPortionsTableCompanion({
    this.id = const Value.absent(),
    this.foodId = const Value.absent(),
    this.unit = const Value.absent(),
    this.label = const Value.absent(),
    this.referenceAmount = const Value.absent(),
    this.canonicalGrams = const Value.absent(),
    this.canonicalMilliliters = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FoodPortionsTableCompanion.insert({
    required String id,
    required String foodId,
    required FoodQuantityUnit unit,
    required String label,
    required double referenceAmount,
    this.canonicalGrams = const Value.absent(),
    this.canonicalMilliliters = const Value.absent(),
    required int sortOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       foodId = Value(foodId),
       unit = Value(unit),
       label = Value(label),
       referenceAmount = Value(referenceAmount),
       sortOrder = Value(sortOrder),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<FoodPortionsTableData> custom({
    Expression<String>? id,
    Expression<String>? foodId,
    Expression<String>? unit,
    Expression<String>? label,
    Expression<double>? referenceAmount,
    Expression<double>? canonicalGrams,
    Expression<double>? canonicalMilliliters,
    Expression<int>? sortOrder,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (foodId != null) 'food_id': foodId,
      if (unit != null) 'unit': unit,
      if (label != null) 'label': label,
      if (referenceAmount != null) 'reference_amount': referenceAmount,
      if (canonicalGrams != null) 'canonical_grams': canonicalGrams,
      if (canonicalMilliliters != null)
        'canonical_milliliters': canonicalMilliliters,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FoodPortionsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? foodId,
    Value<FoodQuantityUnit>? unit,
    Value<String>? label,
    Value<double>? referenceAmount,
    Value<double?>? canonicalGrams,
    Value<double?>? canonicalMilliliters,
    Value<int>? sortOrder,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return FoodPortionsTableCompanion(
      id: id ?? this.id,
      foodId: foodId ?? this.foodId,
      unit: unit ?? this.unit,
      label: label ?? this.label,
      referenceAmount: referenceAmount ?? this.referenceAmount,
      canonicalGrams: canonicalGrams ?? this.canonicalGrams,
      canonicalMilliliters: canonicalMilliliters ?? this.canonicalMilliliters,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (foodId.present) {
      map['food_id'] = Variable<String>(foodId.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(
        $FoodPortionsTableTable.$converterunit.toSql(unit.value),
      );
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (referenceAmount.present) {
      map['reference_amount'] = Variable<double>(referenceAmount.value);
    }
    if (canonicalGrams.present) {
      map['canonical_grams'] = Variable<double>(canonicalGrams.value);
    }
    if (canonicalMilliliters.present) {
      map['canonical_milliliters'] = Variable<double>(
        canonicalMilliliters.value,
      );
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodPortionsTableCompanion(')
          ..write('id: $id, ')
          ..write('foodId: $foodId, ')
          ..write('unit: $unit, ')
          ..write('label: $label, ')
          ..write('referenceAmount: $referenceAmount, ')
          ..write('canonicalGrams: $canonicalGrams, ')
          ..write('canonicalMilliliters: $canonicalMilliliters, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MealEntriesTableTable extends MealEntriesTable
    with TableInfo<$MealEntriesTableTable, MealEntriesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MealEntriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _foodIdMeta = const VerificationMeta('foodId');
  @override
  late final GeneratedColumn<String> foodId = GeneratedColumn<String>(
    'food_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES foods_table (id) ON DELETE RESTRICT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<MealType, String> mealType =
      GeneratedColumn<String>(
        'meal_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<MealType>($MealEntriesTableTable.$convertermealType);
  static const VerificationMeta _originalQuantityValueMeta =
      const VerificationMeta('originalQuantityValue');
  @override
  late final GeneratedColumn<double> originalQuantityValue =
      GeneratedColumn<double>(
        'original_quantity_value',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  @override
  late final GeneratedColumnWithTypeConverter<FoodQuantityUnit, String>
  originalQuantityUnit =
      GeneratedColumn<String>(
        'original_quantity_unit',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<FoodQuantityUnit>(
        $MealEntriesTableTable.$converteroriginalQuantityUnit,
      );
  static const VerificationMeta _canonicalQuantityGramsMeta =
      const VerificationMeta('canonicalQuantityGrams');
  @override
  late final GeneratedColumn<double> canonicalQuantityGrams =
      GeneratedColumn<double>(
        'canonical_quantity_grams',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _canonicalQuantityMillilitersMeta =
      const VerificationMeta('canonicalQuantityMilliliters');
  @override
  late final GeneratedColumn<double> canonicalQuantityMilliliters =
      GeneratedColumn<double>(
        'canonical_quantity_milliliters',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _loggedAtMeta = const VerificationMeta(
    'loggedAt',
  );
  @override
  late final GeneratedColumn<DateTime> loggedAt = GeneratedColumn<DateTime>(
    'logged_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    foodId,
    mealType,
    originalQuantityValue,
    originalQuantityUnit,
    canonicalQuantityGrams,
    canonicalQuantityMilliliters,
    loggedAt,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meal_entries_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<MealEntriesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('food_id')) {
      context.handle(
        _foodIdMeta,
        foodId.isAcceptableOrUnknown(data['food_id']!, _foodIdMeta),
      );
    } else if (isInserting) {
      context.missing(_foodIdMeta);
    }
    if (data.containsKey('original_quantity_value')) {
      context.handle(
        _originalQuantityValueMeta,
        originalQuantityValue.isAcceptableOrUnknown(
          data['original_quantity_value']!,
          _originalQuantityValueMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_originalQuantityValueMeta);
    }
    if (data.containsKey('canonical_quantity_grams')) {
      context.handle(
        _canonicalQuantityGramsMeta,
        canonicalQuantityGrams.isAcceptableOrUnknown(
          data['canonical_quantity_grams']!,
          _canonicalQuantityGramsMeta,
        ),
      );
    }
    if (data.containsKey('canonical_quantity_milliliters')) {
      context.handle(
        _canonicalQuantityMillilitersMeta,
        canonicalQuantityMilliliters.isAcceptableOrUnknown(
          data['canonical_quantity_milliliters']!,
          _canonicalQuantityMillilitersMeta,
        ),
      );
    }
    if (data.containsKey('logged_at')) {
      context.handle(
        _loggedAtMeta,
        loggedAt.isAcceptableOrUnknown(data['logged_at']!, _loggedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_loggedAtMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MealEntriesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MealEntriesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      foodId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}food_id'],
      )!,
      mealType: $MealEntriesTableTable.$convertermealType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}meal_type'],
        )!,
      ),
      originalQuantityValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}original_quantity_value'],
      )!,
      originalQuantityUnit: $MealEntriesTableTable
          .$converteroriginalQuantityUnit
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}original_quantity_unit'],
            )!,
          ),
      canonicalQuantityGrams: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}canonical_quantity_grams'],
      ),
      canonicalQuantityMilliliters: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}canonical_quantity_milliliters'],
      ),
      loggedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}logged_at'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $MealEntriesTableTable createAlias(String alias) {
    return $MealEntriesTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MealType, String, String> $convertermealType =
      const EnumNameConverter<MealType>(MealType.values);
  static JsonTypeConverter2<FoodQuantityUnit, String, String>
  $converteroriginalQuantityUnit = const EnumNameConverter<FoodQuantityUnit>(
    FoodQuantityUnit.values,
  );
}

class MealEntriesTableData extends DataClass
    implements Insertable<MealEntriesTableData> {
  final String id;
  final String foodId;
  final MealType mealType;
  final double originalQuantityValue;
  final FoodQuantityUnit originalQuantityUnit;
  final double? canonicalQuantityGrams;
  final double? canonicalQuantityMilliliters;
  final DateTime loggedAt;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const MealEntriesTableData({
    required this.id,
    required this.foodId,
    required this.mealType,
    required this.originalQuantityValue,
    required this.originalQuantityUnit,
    this.canonicalQuantityGrams,
    this.canonicalQuantityMilliliters,
    required this.loggedAt,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['food_id'] = Variable<String>(foodId);
    {
      map['meal_type'] = Variable<String>(
        $MealEntriesTableTable.$convertermealType.toSql(mealType),
      );
    }
    map['original_quantity_value'] = Variable<double>(originalQuantityValue);
    {
      map['original_quantity_unit'] = Variable<String>(
        $MealEntriesTableTable.$converteroriginalQuantityUnit.toSql(
          originalQuantityUnit,
        ),
      );
    }
    if (!nullToAbsent || canonicalQuantityGrams != null) {
      map['canonical_quantity_grams'] = Variable<double>(
        canonicalQuantityGrams,
      );
    }
    if (!nullToAbsent || canonicalQuantityMilliliters != null) {
      map['canonical_quantity_milliliters'] = Variable<double>(
        canonicalQuantityMilliliters,
      );
    }
    map['logged_at'] = Variable<DateTime>(loggedAt);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MealEntriesTableCompanion toCompanion(bool nullToAbsent) {
    return MealEntriesTableCompanion(
      id: Value(id),
      foodId: Value(foodId),
      mealType: Value(mealType),
      originalQuantityValue: Value(originalQuantityValue),
      originalQuantityUnit: Value(originalQuantityUnit),
      canonicalQuantityGrams: canonicalQuantityGrams == null && nullToAbsent
          ? const Value.absent()
          : Value(canonicalQuantityGrams),
      canonicalQuantityMilliliters:
          canonicalQuantityMilliliters == null && nullToAbsent
          ? const Value.absent()
          : Value(canonicalQuantityMilliliters),
      loggedAt: Value(loggedAt),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory MealEntriesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MealEntriesTableData(
      id: serializer.fromJson<String>(json['id']),
      foodId: serializer.fromJson<String>(json['foodId']),
      mealType: $MealEntriesTableTable.$convertermealType.fromJson(
        serializer.fromJson<String>(json['mealType']),
      ),
      originalQuantityValue: serializer.fromJson<double>(
        json['originalQuantityValue'],
      ),
      originalQuantityUnit: $MealEntriesTableTable
          .$converteroriginalQuantityUnit
          .fromJson(serializer.fromJson<String>(json['originalQuantityUnit'])),
      canonicalQuantityGrams: serializer.fromJson<double?>(
        json['canonicalQuantityGrams'],
      ),
      canonicalQuantityMilliliters: serializer.fromJson<double?>(
        json['canonicalQuantityMilliliters'],
      ),
      loggedAt: serializer.fromJson<DateTime>(json['loggedAt']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'foodId': serializer.toJson<String>(foodId),
      'mealType': serializer.toJson<String>(
        $MealEntriesTableTable.$convertermealType.toJson(mealType),
      ),
      'originalQuantityValue': serializer.toJson<double>(originalQuantityValue),
      'originalQuantityUnit': serializer.toJson<String>(
        $MealEntriesTableTable.$converteroriginalQuantityUnit.toJson(
          originalQuantityUnit,
        ),
      ),
      'canonicalQuantityGrams': serializer.toJson<double?>(
        canonicalQuantityGrams,
      ),
      'canonicalQuantityMilliliters': serializer.toJson<double?>(
        canonicalQuantityMilliliters,
      ),
      'loggedAt': serializer.toJson<DateTime>(loggedAt),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MealEntriesTableData copyWith({
    String? id,
    String? foodId,
    MealType? mealType,
    double? originalQuantityValue,
    FoodQuantityUnit? originalQuantityUnit,
    Value<double?> canonicalQuantityGrams = const Value.absent(),
    Value<double?> canonicalQuantityMilliliters = const Value.absent(),
    DateTime? loggedAt,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => MealEntriesTableData(
    id: id ?? this.id,
    foodId: foodId ?? this.foodId,
    mealType: mealType ?? this.mealType,
    originalQuantityValue: originalQuantityValue ?? this.originalQuantityValue,
    originalQuantityUnit: originalQuantityUnit ?? this.originalQuantityUnit,
    canonicalQuantityGrams: canonicalQuantityGrams.present
        ? canonicalQuantityGrams.value
        : this.canonicalQuantityGrams,
    canonicalQuantityMilliliters: canonicalQuantityMilliliters.present
        ? canonicalQuantityMilliliters.value
        : this.canonicalQuantityMilliliters,
    loggedAt: loggedAt ?? this.loggedAt,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  MealEntriesTableData copyWithCompanion(MealEntriesTableCompanion data) {
    return MealEntriesTableData(
      id: data.id.present ? data.id.value : this.id,
      foodId: data.foodId.present ? data.foodId.value : this.foodId,
      mealType: data.mealType.present ? data.mealType.value : this.mealType,
      originalQuantityValue: data.originalQuantityValue.present
          ? data.originalQuantityValue.value
          : this.originalQuantityValue,
      originalQuantityUnit: data.originalQuantityUnit.present
          ? data.originalQuantityUnit.value
          : this.originalQuantityUnit,
      canonicalQuantityGrams: data.canonicalQuantityGrams.present
          ? data.canonicalQuantityGrams.value
          : this.canonicalQuantityGrams,
      canonicalQuantityMilliliters: data.canonicalQuantityMilliliters.present
          ? data.canonicalQuantityMilliliters.value
          : this.canonicalQuantityMilliliters,
      loggedAt: data.loggedAt.present ? data.loggedAt.value : this.loggedAt,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MealEntriesTableData(')
          ..write('id: $id, ')
          ..write('foodId: $foodId, ')
          ..write('mealType: $mealType, ')
          ..write('originalQuantityValue: $originalQuantityValue, ')
          ..write('originalQuantityUnit: $originalQuantityUnit, ')
          ..write('canonicalQuantityGrams: $canonicalQuantityGrams, ')
          ..write(
            'canonicalQuantityMilliliters: $canonicalQuantityMilliliters, ',
          )
          ..write('loggedAt: $loggedAt, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    foodId,
    mealType,
    originalQuantityValue,
    originalQuantityUnit,
    canonicalQuantityGrams,
    canonicalQuantityMilliliters,
    loggedAt,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MealEntriesTableData &&
          other.id == this.id &&
          other.foodId == this.foodId &&
          other.mealType == this.mealType &&
          other.originalQuantityValue == this.originalQuantityValue &&
          other.originalQuantityUnit == this.originalQuantityUnit &&
          other.canonicalQuantityGrams == this.canonicalQuantityGrams &&
          other.canonicalQuantityMilliliters ==
              this.canonicalQuantityMilliliters &&
          other.loggedAt == this.loggedAt &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MealEntriesTableCompanion extends UpdateCompanion<MealEntriesTableData> {
  final Value<String> id;
  final Value<String> foodId;
  final Value<MealType> mealType;
  final Value<double> originalQuantityValue;
  final Value<FoodQuantityUnit> originalQuantityUnit;
  final Value<double?> canonicalQuantityGrams;
  final Value<double?> canonicalQuantityMilliliters;
  final Value<DateTime> loggedAt;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const MealEntriesTableCompanion({
    this.id = const Value.absent(),
    this.foodId = const Value.absent(),
    this.mealType = const Value.absent(),
    this.originalQuantityValue = const Value.absent(),
    this.originalQuantityUnit = const Value.absent(),
    this.canonicalQuantityGrams = const Value.absent(),
    this.canonicalQuantityMilliliters = const Value.absent(),
    this.loggedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MealEntriesTableCompanion.insert({
    required String id,
    required String foodId,
    required MealType mealType,
    required double originalQuantityValue,
    required FoodQuantityUnit originalQuantityUnit,
    this.canonicalQuantityGrams = const Value.absent(),
    this.canonicalQuantityMilliliters = const Value.absent(),
    required DateTime loggedAt,
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       foodId = Value(foodId),
       mealType = Value(mealType),
       originalQuantityValue = Value(originalQuantityValue),
       originalQuantityUnit = Value(originalQuantityUnit),
       loggedAt = Value(loggedAt),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<MealEntriesTableData> custom({
    Expression<String>? id,
    Expression<String>? foodId,
    Expression<String>? mealType,
    Expression<double>? originalQuantityValue,
    Expression<String>? originalQuantityUnit,
    Expression<double>? canonicalQuantityGrams,
    Expression<double>? canonicalQuantityMilliliters,
    Expression<DateTime>? loggedAt,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (foodId != null) 'food_id': foodId,
      if (mealType != null) 'meal_type': mealType,
      if (originalQuantityValue != null)
        'original_quantity_value': originalQuantityValue,
      if (originalQuantityUnit != null)
        'original_quantity_unit': originalQuantityUnit,
      if (canonicalQuantityGrams != null)
        'canonical_quantity_grams': canonicalQuantityGrams,
      if (canonicalQuantityMilliliters != null)
        'canonical_quantity_milliliters': canonicalQuantityMilliliters,
      if (loggedAt != null) 'logged_at': loggedAt,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MealEntriesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? foodId,
    Value<MealType>? mealType,
    Value<double>? originalQuantityValue,
    Value<FoodQuantityUnit>? originalQuantityUnit,
    Value<double?>? canonicalQuantityGrams,
    Value<double?>? canonicalQuantityMilliliters,
    Value<DateTime>? loggedAt,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return MealEntriesTableCompanion(
      id: id ?? this.id,
      foodId: foodId ?? this.foodId,
      mealType: mealType ?? this.mealType,
      originalQuantityValue:
          originalQuantityValue ?? this.originalQuantityValue,
      originalQuantityUnit: originalQuantityUnit ?? this.originalQuantityUnit,
      canonicalQuantityGrams:
          canonicalQuantityGrams ?? this.canonicalQuantityGrams,
      canonicalQuantityMilliliters:
          canonicalQuantityMilliliters ?? this.canonicalQuantityMilliliters,
      loggedAt: loggedAt ?? this.loggedAt,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (foodId.present) {
      map['food_id'] = Variable<String>(foodId.value);
    }
    if (mealType.present) {
      map['meal_type'] = Variable<String>(
        $MealEntriesTableTable.$convertermealType.toSql(mealType.value),
      );
    }
    if (originalQuantityValue.present) {
      map['original_quantity_value'] = Variable<double>(
        originalQuantityValue.value,
      );
    }
    if (originalQuantityUnit.present) {
      map['original_quantity_unit'] = Variable<String>(
        $MealEntriesTableTable.$converteroriginalQuantityUnit.toSql(
          originalQuantityUnit.value,
        ),
      );
    }
    if (canonicalQuantityGrams.present) {
      map['canonical_quantity_grams'] = Variable<double>(
        canonicalQuantityGrams.value,
      );
    }
    if (canonicalQuantityMilliliters.present) {
      map['canonical_quantity_milliliters'] = Variable<double>(
        canonicalQuantityMilliliters.value,
      );
    }
    if (loggedAt.present) {
      map['logged_at'] = Variable<DateTime>(loggedAt.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MealEntriesTableCompanion(')
          ..write('id: $id, ')
          ..write('foodId: $foodId, ')
          ..write('mealType: $mealType, ')
          ..write('originalQuantityValue: $originalQuantityValue, ')
          ..write('originalQuantityUnit: $originalQuantityUnit, ')
          ..write('canonicalQuantityGrams: $canonicalQuantityGrams, ')
          ..write(
            'canonicalQuantityMilliliters: $canonicalQuantityMilliliters, ',
          )
          ..write('loggedAt: $loggedAt, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HydrationLogsTableTable extends HydrationLogsTable
    with TableInfo<$HydrationLogsTableTable, HydrationLogsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HydrationLogsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _originalAmountValueMeta =
      const VerificationMeta('originalAmountValue');
  @override
  late final GeneratedColumn<double> originalAmountValue =
      GeneratedColumn<double>(
        'original_amount_value',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  @override
  late final GeneratedColumnWithTypeConverter<VolumeUnit, String>
  originalAmountUnit =
      GeneratedColumn<String>(
        'original_amount_unit',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<VolumeUnit>(
        $HydrationLogsTableTable.$converteroriginalAmountUnit,
      );
  static const VerificationMeta _canonicalMillilitersMeta =
      const VerificationMeta('canonicalMilliliters');
  @override
  late final GeneratedColumn<double> canonicalMilliliters =
      GeneratedColumn<double>(
        'canonical_milliliters',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _loggedAtMeta = const VerificationMeta(
    'loggedAt',
  );
  @override
  late final GeneratedColumn<DateTime> loggedAt = GeneratedColumn<DateTime>(
    'logged_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    originalAmountValue,
    originalAmountUnit,
    canonicalMilliliters,
    loggedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'hydration_logs_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<HydrationLogsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('original_amount_value')) {
      context.handle(
        _originalAmountValueMeta,
        originalAmountValue.isAcceptableOrUnknown(
          data['original_amount_value']!,
          _originalAmountValueMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_originalAmountValueMeta);
    }
    if (data.containsKey('canonical_milliliters')) {
      context.handle(
        _canonicalMillilitersMeta,
        canonicalMilliliters.isAcceptableOrUnknown(
          data['canonical_milliliters']!,
          _canonicalMillilitersMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_canonicalMillilitersMeta);
    }
    if (data.containsKey('logged_at')) {
      context.handle(
        _loggedAtMeta,
        loggedAt.isAcceptableOrUnknown(data['logged_at']!, _loggedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_loggedAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HydrationLogsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HydrationLogsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      originalAmountValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}original_amount_value'],
      )!,
      originalAmountUnit: $HydrationLogsTableTable.$converteroriginalAmountUnit
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}original_amount_unit'],
            )!,
          ),
      canonicalMilliliters: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}canonical_milliliters'],
      )!,
      loggedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}logged_at'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $HydrationLogsTableTable createAlias(String alias) {
    return $HydrationLogsTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<VolumeUnit, String, String>
  $converteroriginalAmountUnit = const EnumNameConverter<VolumeUnit>(
    VolumeUnit.values,
  );
}

class HydrationLogsTableData extends DataClass
    implements Insertable<HydrationLogsTableData> {
  final String id;
  final double originalAmountValue;
  final VolumeUnit originalAmountUnit;
  final double canonicalMilliliters;
  final DateTime loggedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const HydrationLogsTableData({
    required this.id,
    required this.originalAmountValue,
    required this.originalAmountUnit,
    required this.canonicalMilliliters,
    required this.loggedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['original_amount_value'] = Variable<double>(originalAmountValue);
    {
      map['original_amount_unit'] = Variable<String>(
        $HydrationLogsTableTable.$converteroriginalAmountUnit.toSql(
          originalAmountUnit,
        ),
      );
    }
    map['canonical_milliliters'] = Variable<double>(canonicalMilliliters);
    map['logged_at'] = Variable<DateTime>(loggedAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  HydrationLogsTableCompanion toCompanion(bool nullToAbsent) {
    return HydrationLogsTableCompanion(
      id: Value(id),
      originalAmountValue: Value(originalAmountValue),
      originalAmountUnit: Value(originalAmountUnit),
      canonicalMilliliters: Value(canonicalMilliliters),
      loggedAt: Value(loggedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory HydrationLogsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HydrationLogsTableData(
      id: serializer.fromJson<String>(json['id']),
      originalAmountValue: serializer.fromJson<double>(
        json['originalAmountValue'],
      ),
      originalAmountUnit: $HydrationLogsTableTable.$converteroriginalAmountUnit
          .fromJson(serializer.fromJson<String>(json['originalAmountUnit'])),
      canonicalMilliliters: serializer.fromJson<double>(
        json['canonicalMilliliters'],
      ),
      loggedAt: serializer.fromJson<DateTime>(json['loggedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'originalAmountValue': serializer.toJson<double>(originalAmountValue),
      'originalAmountUnit': serializer.toJson<String>(
        $HydrationLogsTableTable.$converteroriginalAmountUnit.toJson(
          originalAmountUnit,
        ),
      ),
      'canonicalMilliliters': serializer.toJson<double>(canonicalMilliliters),
      'loggedAt': serializer.toJson<DateTime>(loggedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  HydrationLogsTableData copyWith({
    String? id,
    double? originalAmountValue,
    VolumeUnit? originalAmountUnit,
    double? canonicalMilliliters,
    DateTime? loggedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => HydrationLogsTableData(
    id: id ?? this.id,
    originalAmountValue: originalAmountValue ?? this.originalAmountValue,
    originalAmountUnit: originalAmountUnit ?? this.originalAmountUnit,
    canonicalMilliliters: canonicalMilliliters ?? this.canonicalMilliliters,
    loggedAt: loggedAt ?? this.loggedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  HydrationLogsTableData copyWithCompanion(HydrationLogsTableCompanion data) {
    return HydrationLogsTableData(
      id: data.id.present ? data.id.value : this.id,
      originalAmountValue: data.originalAmountValue.present
          ? data.originalAmountValue.value
          : this.originalAmountValue,
      originalAmountUnit: data.originalAmountUnit.present
          ? data.originalAmountUnit.value
          : this.originalAmountUnit,
      canonicalMilliliters: data.canonicalMilliliters.present
          ? data.canonicalMilliliters.value
          : this.canonicalMilliliters,
      loggedAt: data.loggedAt.present ? data.loggedAt.value : this.loggedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HydrationLogsTableData(')
          ..write('id: $id, ')
          ..write('originalAmountValue: $originalAmountValue, ')
          ..write('originalAmountUnit: $originalAmountUnit, ')
          ..write('canonicalMilliliters: $canonicalMilliliters, ')
          ..write('loggedAt: $loggedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    originalAmountValue,
    originalAmountUnit,
    canonicalMilliliters,
    loggedAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HydrationLogsTableData &&
          other.id == this.id &&
          other.originalAmountValue == this.originalAmountValue &&
          other.originalAmountUnit == this.originalAmountUnit &&
          other.canonicalMilliliters == this.canonicalMilliliters &&
          other.loggedAt == this.loggedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class HydrationLogsTableCompanion
    extends UpdateCompanion<HydrationLogsTableData> {
  final Value<String> id;
  final Value<double> originalAmountValue;
  final Value<VolumeUnit> originalAmountUnit;
  final Value<double> canonicalMilliliters;
  final Value<DateTime> loggedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const HydrationLogsTableCompanion({
    this.id = const Value.absent(),
    this.originalAmountValue = const Value.absent(),
    this.originalAmountUnit = const Value.absent(),
    this.canonicalMilliliters = const Value.absent(),
    this.loggedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HydrationLogsTableCompanion.insert({
    required String id,
    required double originalAmountValue,
    required VolumeUnit originalAmountUnit,
    required double canonicalMilliliters,
    required DateTime loggedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       originalAmountValue = Value(originalAmountValue),
       originalAmountUnit = Value(originalAmountUnit),
       canonicalMilliliters = Value(canonicalMilliliters),
       loggedAt = Value(loggedAt),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<HydrationLogsTableData> custom({
    Expression<String>? id,
    Expression<double>? originalAmountValue,
    Expression<String>? originalAmountUnit,
    Expression<double>? canonicalMilliliters,
    Expression<DateTime>? loggedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (originalAmountValue != null)
        'original_amount_value': originalAmountValue,
      if (originalAmountUnit != null)
        'original_amount_unit': originalAmountUnit,
      if (canonicalMilliliters != null)
        'canonical_milliliters': canonicalMilliliters,
      if (loggedAt != null) 'logged_at': loggedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HydrationLogsTableCompanion copyWith({
    Value<String>? id,
    Value<double>? originalAmountValue,
    Value<VolumeUnit>? originalAmountUnit,
    Value<double>? canonicalMilliliters,
    Value<DateTime>? loggedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return HydrationLogsTableCompanion(
      id: id ?? this.id,
      originalAmountValue: originalAmountValue ?? this.originalAmountValue,
      originalAmountUnit: originalAmountUnit ?? this.originalAmountUnit,
      canonicalMilliliters: canonicalMilliliters ?? this.canonicalMilliliters,
      loggedAt: loggedAt ?? this.loggedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (originalAmountValue.present) {
      map['original_amount_value'] = Variable<double>(
        originalAmountValue.value,
      );
    }
    if (originalAmountUnit.present) {
      map['original_amount_unit'] = Variable<String>(
        $HydrationLogsTableTable.$converteroriginalAmountUnit.toSql(
          originalAmountUnit.value,
        ),
      );
    }
    if (canonicalMilliliters.present) {
      map['canonical_milliliters'] = Variable<double>(
        canonicalMilliliters.value,
      );
    }
    if (loggedAt.present) {
      map['logged_at'] = Variable<DateTime>(loggedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HydrationLogsTableCompanion(')
          ..write('id: $id, ')
          ..write('originalAmountValue: $originalAmountValue, ')
          ..write('originalAmountUnit: $originalAmountUnit, ')
          ..write('canonicalMilliliters: $canonicalMilliliters, ')
          ..write('loggedAt: $loggedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SavedMealsTableTable extends SavedMealsTable
    with TableInfo<$SavedMealsTableTable, SavedMealsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavedMealsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, notes, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'saved_meals_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<SavedMealsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SavedMealsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SavedMealsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SavedMealsTableTable createAlias(String alias) {
    return $SavedMealsTableTable(attachedDatabase, alias);
  }
}

class SavedMealsTableData extends DataClass
    implements Insertable<SavedMealsTableData> {
  final String id;
  final String name;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SavedMealsTableData({
    required this.id,
    required this.name,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SavedMealsTableCompanion toCompanion(bool nullToAbsent) {
    return SavedMealsTableCompanion(
      id: Value(id),
      name: Value(name),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SavedMealsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavedMealsTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SavedMealsTableData copyWith({
    String? id,
    String? name,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => SavedMealsTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SavedMealsTableData copyWithCompanion(SavedMealsTableCompanion data) {
    return SavedMealsTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SavedMealsTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, notes, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavedMealsTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SavedMealsTableCompanion extends UpdateCompanion<SavedMealsTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SavedMealsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SavedMealsTableCompanion.insert({
    required String id,
    required String name,
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<SavedMealsTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SavedMealsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SavedMealsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavedMealsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SavedMealItemsTableTable extends SavedMealItemsTable
    with TableInfo<$SavedMealItemsTableTable, SavedMealItemsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavedMealItemsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _savedMealIdMeta = const VerificationMeta(
    'savedMealId',
  );
  @override
  late final GeneratedColumn<String> savedMealId = GeneratedColumn<String>(
    'saved_meal_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES saved_meals_table (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _foodIdMeta = const VerificationMeta('foodId');
  @override
  late final GeneratedColumn<String> foodId = GeneratedColumn<String>(
    'food_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES foods_table (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _originalQuantityValueMeta =
      const VerificationMeta('originalQuantityValue');
  @override
  late final GeneratedColumn<double> originalQuantityValue =
      GeneratedColumn<double>(
        'original_quantity_value',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  @override
  late final GeneratedColumnWithTypeConverter<FoodQuantityUnit, String>
  originalQuantityUnit =
      GeneratedColumn<String>(
        'original_quantity_unit',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<FoodQuantityUnit>(
        $SavedMealItemsTableTable.$converteroriginalQuantityUnit,
      );
  static const VerificationMeta _canonicalQuantityGramsMeta =
      const VerificationMeta('canonicalQuantityGrams');
  @override
  late final GeneratedColumn<double> canonicalQuantityGrams =
      GeneratedColumn<double>(
        'canonical_quantity_grams',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _canonicalQuantityMillilitersMeta =
      const VerificationMeta('canonicalQuantityMilliliters');
  @override
  late final GeneratedColumn<double> canonicalQuantityMilliliters =
      GeneratedColumn<double>(
        'canonical_quantity_milliliters',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _orderIndexMeta = const VerificationMeta(
    'orderIndex',
  );
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
    'order_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    savedMealId,
    foodId,
    originalQuantityValue,
    originalQuantityUnit,
    canonicalQuantityGrams,
    canonicalQuantityMilliliters,
    orderIndex,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'saved_meal_items_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<SavedMealItemsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('saved_meal_id')) {
      context.handle(
        _savedMealIdMeta,
        savedMealId.isAcceptableOrUnknown(
          data['saved_meal_id']!,
          _savedMealIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_savedMealIdMeta);
    }
    if (data.containsKey('food_id')) {
      context.handle(
        _foodIdMeta,
        foodId.isAcceptableOrUnknown(data['food_id']!, _foodIdMeta),
      );
    } else if (isInserting) {
      context.missing(_foodIdMeta);
    }
    if (data.containsKey('original_quantity_value')) {
      context.handle(
        _originalQuantityValueMeta,
        originalQuantityValue.isAcceptableOrUnknown(
          data['original_quantity_value']!,
          _originalQuantityValueMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_originalQuantityValueMeta);
    }
    if (data.containsKey('canonical_quantity_grams')) {
      context.handle(
        _canonicalQuantityGramsMeta,
        canonicalQuantityGrams.isAcceptableOrUnknown(
          data['canonical_quantity_grams']!,
          _canonicalQuantityGramsMeta,
        ),
      );
    }
    if (data.containsKey('canonical_quantity_milliliters')) {
      context.handle(
        _canonicalQuantityMillilitersMeta,
        canonicalQuantityMilliliters.isAcceptableOrUnknown(
          data['canonical_quantity_milliliters']!,
          _canonicalQuantityMillilitersMeta,
        ),
      );
    }
    if (data.containsKey('order_index')) {
      context.handle(
        _orderIndexMeta,
        orderIndex.isAcceptableOrUnknown(data['order_index']!, _orderIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIndexMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SavedMealItemsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SavedMealItemsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      savedMealId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}saved_meal_id'],
      )!,
      foodId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}food_id'],
      )!,
      originalQuantityValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}original_quantity_value'],
      )!,
      originalQuantityUnit: $SavedMealItemsTableTable
          .$converteroriginalQuantityUnit
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}original_quantity_unit'],
            )!,
          ),
      canonicalQuantityGrams: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}canonical_quantity_grams'],
      ),
      canonicalQuantityMilliliters: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}canonical_quantity_milliliters'],
      ),
      orderIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order_index'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SavedMealItemsTableTable createAlias(String alias) {
    return $SavedMealItemsTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<FoodQuantityUnit, String, String>
  $converteroriginalQuantityUnit = const EnumNameConverter<FoodQuantityUnit>(
    FoodQuantityUnit.values,
  );
}

class SavedMealItemsTableData extends DataClass
    implements Insertable<SavedMealItemsTableData> {
  final String id;
  final String savedMealId;
  final String foodId;
  final double originalQuantityValue;
  final FoodQuantityUnit originalQuantityUnit;
  final double? canonicalQuantityGrams;
  final double? canonicalQuantityMilliliters;
  final int orderIndex;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SavedMealItemsTableData({
    required this.id,
    required this.savedMealId,
    required this.foodId,
    required this.originalQuantityValue,
    required this.originalQuantityUnit,
    this.canonicalQuantityGrams,
    this.canonicalQuantityMilliliters,
    required this.orderIndex,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['saved_meal_id'] = Variable<String>(savedMealId);
    map['food_id'] = Variable<String>(foodId);
    map['original_quantity_value'] = Variable<double>(originalQuantityValue);
    {
      map['original_quantity_unit'] = Variable<String>(
        $SavedMealItemsTableTable.$converteroriginalQuantityUnit.toSql(
          originalQuantityUnit,
        ),
      );
    }
    if (!nullToAbsent || canonicalQuantityGrams != null) {
      map['canonical_quantity_grams'] = Variable<double>(
        canonicalQuantityGrams,
      );
    }
    if (!nullToAbsent || canonicalQuantityMilliliters != null) {
      map['canonical_quantity_milliliters'] = Variable<double>(
        canonicalQuantityMilliliters,
      );
    }
    map['order_index'] = Variable<int>(orderIndex);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SavedMealItemsTableCompanion toCompanion(bool nullToAbsent) {
    return SavedMealItemsTableCompanion(
      id: Value(id),
      savedMealId: Value(savedMealId),
      foodId: Value(foodId),
      originalQuantityValue: Value(originalQuantityValue),
      originalQuantityUnit: Value(originalQuantityUnit),
      canonicalQuantityGrams: canonicalQuantityGrams == null && nullToAbsent
          ? const Value.absent()
          : Value(canonicalQuantityGrams),
      canonicalQuantityMilliliters:
          canonicalQuantityMilliliters == null && nullToAbsent
          ? const Value.absent()
          : Value(canonicalQuantityMilliliters),
      orderIndex: Value(orderIndex),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SavedMealItemsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavedMealItemsTableData(
      id: serializer.fromJson<String>(json['id']),
      savedMealId: serializer.fromJson<String>(json['savedMealId']),
      foodId: serializer.fromJson<String>(json['foodId']),
      originalQuantityValue: serializer.fromJson<double>(
        json['originalQuantityValue'],
      ),
      originalQuantityUnit: $SavedMealItemsTableTable
          .$converteroriginalQuantityUnit
          .fromJson(serializer.fromJson<String>(json['originalQuantityUnit'])),
      canonicalQuantityGrams: serializer.fromJson<double?>(
        json['canonicalQuantityGrams'],
      ),
      canonicalQuantityMilliliters: serializer.fromJson<double?>(
        json['canonicalQuantityMilliliters'],
      ),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'savedMealId': serializer.toJson<String>(savedMealId),
      'foodId': serializer.toJson<String>(foodId),
      'originalQuantityValue': serializer.toJson<double>(originalQuantityValue),
      'originalQuantityUnit': serializer.toJson<String>(
        $SavedMealItemsTableTable.$converteroriginalQuantityUnit.toJson(
          originalQuantityUnit,
        ),
      ),
      'canonicalQuantityGrams': serializer.toJson<double?>(
        canonicalQuantityGrams,
      ),
      'canonicalQuantityMilliliters': serializer.toJson<double?>(
        canonicalQuantityMilliliters,
      ),
      'orderIndex': serializer.toJson<int>(orderIndex),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SavedMealItemsTableData copyWith({
    String? id,
    String? savedMealId,
    String? foodId,
    double? originalQuantityValue,
    FoodQuantityUnit? originalQuantityUnit,
    Value<double?> canonicalQuantityGrams = const Value.absent(),
    Value<double?> canonicalQuantityMilliliters = const Value.absent(),
    int? orderIndex,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => SavedMealItemsTableData(
    id: id ?? this.id,
    savedMealId: savedMealId ?? this.savedMealId,
    foodId: foodId ?? this.foodId,
    originalQuantityValue: originalQuantityValue ?? this.originalQuantityValue,
    originalQuantityUnit: originalQuantityUnit ?? this.originalQuantityUnit,
    canonicalQuantityGrams: canonicalQuantityGrams.present
        ? canonicalQuantityGrams.value
        : this.canonicalQuantityGrams,
    canonicalQuantityMilliliters: canonicalQuantityMilliliters.present
        ? canonicalQuantityMilliliters.value
        : this.canonicalQuantityMilliliters,
    orderIndex: orderIndex ?? this.orderIndex,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SavedMealItemsTableData copyWithCompanion(SavedMealItemsTableCompanion data) {
    return SavedMealItemsTableData(
      id: data.id.present ? data.id.value : this.id,
      savedMealId: data.savedMealId.present
          ? data.savedMealId.value
          : this.savedMealId,
      foodId: data.foodId.present ? data.foodId.value : this.foodId,
      originalQuantityValue: data.originalQuantityValue.present
          ? data.originalQuantityValue.value
          : this.originalQuantityValue,
      originalQuantityUnit: data.originalQuantityUnit.present
          ? data.originalQuantityUnit.value
          : this.originalQuantityUnit,
      canonicalQuantityGrams: data.canonicalQuantityGrams.present
          ? data.canonicalQuantityGrams.value
          : this.canonicalQuantityGrams,
      canonicalQuantityMilliliters: data.canonicalQuantityMilliliters.present
          ? data.canonicalQuantityMilliliters.value
          : this.canonicalQuantityMilliliters,
      orderIndex: data.orderIndex.present
          ? data.orderIndex.value
          : this.orderIndex,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SavedMealItemsTableData(')
          ..write('id: $id, ')
          ..write('savedMealId: $savedMealId, ')
          ..write('foodId: $foodId, ')
          ..write('originalQuantityValue: $originalQuantityValue, ')
          ..write('originalQuantityUnit: $originalQuantityUnit, ')
          ..write('canonicalQuantityGrams: $canonicalQuantityGrams, ')
          ..write(
            'canonicalQuantityMilliliters: $canonicalQuantityMilliliters, ',
          )
          ..write('orderIndex: $orderIndex, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    savedMealId,
    foodId,
    originalQuantityValue,
    originalQuantityUnit,
    canonicalQuantityGrams,
    canonicalQuantityMilliliters,
    orderIndex,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavedMealItemsTableData &&
          other.id == this.id &&
          other.savedMealId == this.savedMealId &&
          other.foodId == this.foodId &&
          other.originalQuantityValue == this.originalQuantityValue &&
          other.originalQuantityUnit == this.originalQuantityUnit &&
          other.canonicalQuantityGrams == this.canonicalQuantityGrams &&
          other.canonicalQuantityMilliliters ==
              this.canonicalQuantityMilliliters &&
          other.orderIndex == this.orderIndex &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SavedMealItemsTableCompanion
    extends UpdateCompanion<SavedMealItemsTableData> {
  final Value<String> id;
  final Value<String> savedMealId;
  final Value<String> foodId;
  final Value<double> originalQuantityValue;
  final Value<FoodQuantityUnit> originalQuantityUnit;
  final Value<double?> canonicalQuantityGrams;
  final Value<double?> canonicalQuantityMilliliters;
  final Value<int> orderIndex;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SavedMealItemsTableCompanion({
    this.id = const Value.absent(),
    this.savedMealId = const Value.absent(),
    this.foodId = const Value.absent(),
    this.originalQuantityValue = const Value.absent(),
    this.originalQuantityUnit = const Value.absent(),
    this.canonicalQuantityGrams = const Value.absent(),
    this.canonicalQuantityMilliliters = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SavedMealItemsTableCompanion.insert({
    required String id,
    required String savedMealId,
    required String foodId,
    required double originalQuantityValue,
    required FoodQuantityUnit originalQuantityUnit,
    this.canonicalQuantityGrams = const Value.absent(),
    this.canonicalQuantityMilliliters = const Value.absent(),
    required int orderIndex,
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       savedMealId = Value(savedMealId),
       foodId = Value(foodId),
       originalQuantityValue = Value(originalQuantityValue),
       originalQuantityUnit = Value(originalQuantityUnit),
       orderIndex = Value(orderIndex),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<SavedMealItemsTableData> custom({
    Expression<String>? id,
    Expression<String>? savedMealId,
    Expression<String>? foodId,
    Expression<double>? originalQuantityValue,
    Expression<String>? originalQuantityUnit,
    Expression<double>? canonicalQuantityGrams,
    Expression<double>? canonicalQuantityMilliliters,
    Expression<int>? orderIndex,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (savedMealId != null) 'saved_meal_id': savedMealId,
      if (foodId != null) 'food_id': foodId,
      if (originalQuantityValue != null)
        'original_quantity_value': originalQuantityValue,
      if (originalQuantityUnit != null)
        'original_quantity_unit': originalQuantityUnit,
      if (canonicalQuantityGrams != null)
        'canonical_quantity_grams': canonicalQuantityGrams,
      if (canonicalQuantityMilliliters != null)
        'canonical_quantity_milliliters': canonicalQuantityMilliliters,
      if (orderIndex != null) 'order_index': orderIndex,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SavedMealItemsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? savedMealId,
    Value<String>? foodId,
    Value<double>? originalQuantityValue,
    Value<FoodQuantityUnit>? originalQuantityUnit,
    Value<double?>? canonicalQuantityGrams,
    Value<double?>? canonicalQuantityMilliliters,
    Value<int>? orderIndex,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SavedMealItemsTableCompanion(
      id: id ?? this.id,
      savedMealId: savedMealId ?? this.savedMealId,
      foodId: foodId ?? this.foodId,
      originalQuantityValue:
          originalQuantityValue ?? this.originalQuantityValue,
      originalQuantityUnit: originalQuantityUnit ?? this.originalQuantityUnit,
      canonicalQuantityGrams:
          canonicalQuantityGrams ?? this.canonicalQuantityGrams,
      canonicalQuantityMilliliters:
          canonicalQuantityMilliliters ?? this.canonicalQuantityMilliliters,
      orderIndex: orderIndex ?? this.orderIndex,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (savedMealId.present) {
      map['saved_meal_id'] = Variable<String>(savedMealId.value);
    }
    if (foodId.present) {
      map['food_id'] = Variable<String>(foodId.value);
    }
    if (originalQuantityValue.present) {
      map['original_quantity_value'] = Variable<double>(
        originalQuantityValue.value,
      );
    }
    if (originalQuantityUnit.present) {
      map['original_quantity_unit'] = Variable<String>(
        $SavedMealItemsTableTable.$converteroriginalQuantityUnit.toSql(
          originalQuantityUnit.value,
        ),
      );
    }
    if (canonicalQuantityGrams.present) {
      map['canonical_quantity_grams'] = Variable<double>(
        canonicalQuantityGrams.value,
      );
    }
    if (canonicalQuantityMilliliters.present) {
      map['canonical_quantity_milliliters'] = Variable<double>(
        canonicalQuantityMilliliters.value,
      );
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavedMealItemsTableCompanion(')
          ..write('id: $id, ')
          ..write('savedMealId: $savedMealId, ')
          ..write('foodId: $foodId, ')
          ..write('originalQuantityValue: $originalQuantityValue, ')
          ..write('originalQuantityUnit: $originalQuantityUnit, ')
          ..write('canonicalQuantityGrams: $canonicalQuantityGrams, ')
          ..write(
            'canonicalQuantityMilliliters: $canonicalQuantityMilliliters, ',
          )
          ..write('orderIndex: $orderIndex, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RemindersTableTable extends RemindersTable
    with TableInfo<$RemindersTableTable, RemindersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RemindersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ReminderType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<ReminderType>($RemindersTableTable.$convertertype);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timeOfDayMeta = const VerificationMeta(
    'timeOfDay',
  );
  @override
  late final GeneratedColumn<String> timeOfDay = GeneratedColumn<String>(
    'time_of_day',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 16,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isEnabledMeta = const VerificationMeta(
    'isEnabled',
  );
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
    'is_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isUserDisabledMeta = const VerificationMeta(
    'isUserDisabled',
  );
  @override
  late final GeneratedColumn<bool> isUserDisabled = GeneratedColumn<bool>(
    'is_user_disabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_user_disabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    title,
    timeOfDay,
    isEnabled,
    isUserDisabled,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminders_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<RemindersTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('time_of_day')) {
      context.handle(
        _timeOfDayMeta,
        timeOfDay.isAcceptableOrUnknown(data['time_of_day']!, _timeOfDayMeta),
      );
    } else if (isInserting) {
      context.missing(_timeOfDayMeta);
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    }
    if (data.containsKey('is_user_disabled')) {
      context.handle(
        _isUserDisabledMeta,
        isUserDisabled.isAcceptableOrUnknown(
          data['is_user_disabled']!,
          _isUserDisabledMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RemindersTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RemindersTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      type: $RemindersTableTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      timeOfDay: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}time_of_day'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_enabled'],
      )!,
      isUserDisabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_user_disabled'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $RemindersTableTable createAlias(String alias) {
    return $RemindersTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ReminderType, String, String> $convertertype =
      const EnumNameConverter<ReminderType>(ReminderType.values);
}

class RemindersTableData extends DataClass
    implements Insertable<RemindersTableData> {
  final String id;
  final ReminderType type;
  final String title;
  final String timeOfDay;
  final bool isEnabled;
  final bool isUserDisabled;
  final DateTime createdAt;
  final DateTime updatedAt;
  const RemindersTableData({
    required this.id,
    required this.type,
    required this.title,
    required this.timeOfDay,
    required this.isEnabled,
    required this.isUserDisabled,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    {
      map['type'] = Variable<String>(
        $RemindersTableTable.$convertertype.toSql(type),
      );
    }
    map['title'] = Variable<String>(title);
    map['time_of_day'] = Variable<String>(timeOfDay);
    map['is_enabled'] = Variable<bool>(isEnabled);
    map['is_user_disabled'] = Variable<bool>(isUserDisabled);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RemindersTableCompanion toCompanion(bool nullToAbsent) {
    return RemindersTableCompanion(
      id: Value(id),
      type: Value(type),
      title: Value(title),
      timeOfDay: Value(timeOfDay),
      isEnabled: Value(isEnabled),
      isUserDisabled: Value(isUserDisabled),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory RemindersTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RemindersTableData(
      id: serializer.fromJson<String>(json['id']),
      type: $RemindersTableTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      title: serializer.fromJson<String>(json['title']),
      timeOfDay: serializer.fromJson<String>(json['timeOfDay']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
      isUserDisabled: serializer.fromJson<bool>(json['isUserDisabled']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(
        $RemindersTableTable.$convertertype.toJson(type),
      ),
      'title': serializer.toJson<String>(title),
      'timeOfDay': serializer.toJson<String>(timeOfDay),
      'isEnabled': serializer.toJson<bool>(isEnabled),
      'isUserDisabled': serializer.toJson<bool>(isUserDisabled),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RemindersTableData copyWith({
    String? id,
    ReminderType? type,
    String? title,
    String? timeOfDay,
    bool? isEnabled,
    bool? isUserDisabled,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => RemindersTableData(
    id: id ?? this.id,
    type: type ?? this.type,
    title: title ?? this.title,
    timeOfDay: timeOfDay ?? this.timeOfDay,
    isEnabled: isEnabled ?? this.isEnabled,
    isUserDisabled: isUserDisabled ?? this.isUserDisabled,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  RemindersTableData copyWithCompanion(RemindersTableCompanion data) {
    return RemindersTableData(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      title: data.title.present ? data.title.value : this.title,
      timeOfDay: data.timeOfDay.present ? data.timeOfDay.value : this.timeOfDay,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      isUserDisabled: data.isUserDisabled.present
          ? data.isUserDisabled.value
          : this.isUserDisabled,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RemindersTableData(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('timeOfDay: $timeOfDay, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('isUserDisabled: $isUserDisabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    type,
    title,
    timeOfDay,
    isEnabled,
    isUserDisabled,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RemindersTableData &&
          other.id == this.id &&
          other.type == this.type &&
          other.title == this.title &&
          other.timeOfDay == this.timeOfDay &&
          other.isEnabled == this.isEnabled &&
          other.isUserDisabled == this.isUserDisabled &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RemindersTableCompanion extends UpdateCompanion<RemindersTableData> {
  final Value<String> id;
  final Value<ReminderType> type;
  final Value<String> title;
  final Value<String> timeOfDay;
  final Value<bool> isEnabled;
  final Value<bool> isUserDisabled;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const RemindersTableCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.title = const Value.absent(),
    this.timeOfDay = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.isUserDisabled = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RemindersTableCompanion.insert({
    required String id,
    required ReminderType type,
    required String title,
    required String timeOfDay,
    this.isEnabled = const Value.absent(),
    this.isUserDisabled = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       type = Value(type),
       title = Value(title),
       timeOfDay = Value(timeOfDay),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<RemindersTableData> custom({
    Expression<String>? id,
    Expression<String>? type,
    Expression<String>? title,
    Expression<String>? timeOfDay,
    Expression<bool>? isEnabled,
    Expression<bool>? isUserDisabled,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (title != null) 'title': title,
      if (timeOfDay != null) 'time_of_day': timeOfDay,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (isUserDisabled != null) 'is_user_disabled': isUserDisabled,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RemindersTableCompanion copyWith({
    Value<String>? id,
    Value<ReminderType>? type,
    Value<String>? title,
    Value<String>? timeOfDay,
    Value<bool>? isEnabled,
    Value<bool>? isUserDisabled,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return RemindersTableCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      timeOfDay: timeOfDay ?? this.timeOfDay,
      isEnabled: isEnabled ?? this.isEnabled,
      isUserDisabled: isUserDisabled ?? this.isUserDisabled,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $RemindersTableTable.$convertertype.toSql(type.value),
      );
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (timeOfDay.present) {
      map['time_of_day'] = Variable<String>(timeOfDay.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (isUserDisabled.present) {
      map['is_user_disabled'] = Variable<bool>(isUserDisabled.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RemindersTableCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('timeOfDay: $timeOfDay, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('isUserDisabled: $isUserDisabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HealthProfilesTableTable extends HealthProfilesTable
    with TableInfo<$HealthProfilesTableTable, HealthProfilesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HealthProfilesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _healthConditionsMeta = const VerificationMeta(
    'healthConditions',
  );
  @override
  late final GeneratedColumn<String> healthConditions = GeneratedColumn<String>(
    'health_conditions',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _medicationsMeta = const VerificationMeta(
    'medications',
  );
  @override
  late final GeneratedColumn<String> medications = GeneratedColumn<String>(
    'medications',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _allergiesMeta = const VerificationMeta(
    'allergies',
  );
  @override
  late final GeneratedColumn<String> allergies = GeneratedColumn<String>(
    'allergies',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _checkInCadenceHoursMeta =
      const VerificationMeta('checkInCadenceHours');
  @override
  late final GeneratedColumn<int> checkInCadenceHours = GeneratedColumn<int>(
    'check_in_cadence_hours',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(8),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    healthConditions,
    medications,
    allergies,
    notes,
    checkInCadenceHours,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'health_profiles_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<HealthProfilesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('health_conditions')) {
      context.handle(
        _healthConditionsMeta,
        healthConditions.isAcceptableOrUnknown(
          data['health_conditions']!,
          _healthConditionsMeta,
        ),
      );
    }
    if (data.containsKey('medications')) {
      context.handle(
        _medicationsMeta,
        medications.isAcceptableOrUnknown(
          data['medications']!,
          _medicationsMeta,
        ),
      );
    }
    if (data.containsKey('allergies')) {
      context.handle(
        _allergiesMeta,
        allergies.isAcceptableOrUnknown(data['allergies']!, _allergiesMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('check_in_cadence_hours')) {
      context.handle(
        _checkInCadenceHoursMeta,
        checkInCadenceHours.isAcceptableOrUnknown(
          data['check_in_cadence_hours']!,
          _checkInCadenceHoursMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HealthProfilesTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HealthProfilesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      healthConditions: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}health_conditions'],
      )!,
      medications: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}medications'],
      )!,
      allergies: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}allergies'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      checkInCadenceHours: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}check_in_cadence_hours'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $HealthProfilesTableTable createAlias(String alias) {
    return $HealthProfilesTableTable(attachedDatabase, alias);
  }
}

class HealthProfilesTableData extends DataClass
    implements Insertable<HealthProfilesTableData> {
  final String id;
  final String healthConditions;
  final String medications;
  final String allergies;
  final String? notes;
  final int checkInCadenceHours;
  final DateTime createdAt;
  final DateTime updatedAt;
  const HealthProfilesTableData({
    required this.id,
    required this.healthConditions,
    required this.medications,
    required this.allergies,
    this.notes,
    required this.checkInCadenceHours,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['health_conditions'] = Variable<String>(healthConditions);
    map['medications'] = Variable<String>(medications);
    map['allergies'] = Variable<String>(allergies);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['check_in_cadence_hours'] = Variable<int>(checkInCadenceHours);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  HealthProfilesTableCompanion toCompanion(bool nullToAbsent) {
    return HealthProfilesTableCompanion(
      id: Value(id),
      healthConditions: Value(healthConditions),
      medications: Value(medications),
      allergies: Value(allergies),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      checkInCadenceHours: Value(checkInCadenceHours),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory HealthProfilesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HealthProfilesTableData(
      id: serializer.fromJson<String>(json['id']),
      healthConditions: serializer.fromJson<String>(json['healthConditions']),
      medications: serializer.fromJson<String>(json['medications']),
      allergies: serializer.fromJson<String>(json['allergies']),
      notes: serializer.fromJson<String?>(json['notes']),
      checkInCadenceHours: serializer.fromJson<int>(
        json['checkInCadenceHours'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'healthConditions': serializer.toJson<String>(healthConditions),
      'medications': serializer.toJson<String>(medications),
      'allergies': serializer.toJson<String>(allergies),
      'notes': serializer.toJson<String?>(notes),
      'checkInCadenceHours': serializer.toJson<int>(checkInCadenceHours),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  HealthProfilesTableData copyWith({
    String? id,
    String? healthConditions,
    String? medications,
    String? allergies,
    Value<String?> notes = const Value.absent(),
    int? checkInCadenceHours,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => HealthProfilesTableData(
    id: id ?? this.id,
    healthConditions: healthConditions ?? this.healthConditions,
    medications: medications ?? this.medications,
    allergies: allergies ?? this.allergies,
    notes: notes.present ? notes.value : this.notes,
    checkInCadenceHours: checkInCadenceHours ?? this.checkInCadenceHours,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  HealthProfilesTableData copyWithCompanion(HealthProfilesTableCompanion data) {
    return HealthProfilesTableData(
      id: data.id.present ? data.id.value : this.id,
      healthConditions: data.healthConditions.present
          ? data.healthConditions.value
          : this.healthConditions,
      medications: data.medications.present
          ? data.medications.value
          : this.medications,
      allergies: data.allergies.present ? data.allergies.value : this.allergies,
      notes: data.notes.present ? data.notes.value : this.notes,
      checkInCadenceHours: data.checkInCadenceHours.present
          ? data.checkInCadenceHours.value
          : this.checkInCadenceHours,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HealthProfilesTableData(')
          ..write('id: $id, ')
          ..write('healthConditions: $healthConditions, ')
          ..write('medications: $medications, ')
          ..write('allergies: $allergies, ')
          ..write('notes: $notes, ')
          ..write('checkInCadenceHours: $checkInCadenceHours, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    healthConditions,
    medications,
    allergies,
    notes,
    checkInCadenceHours,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HealthProfilesTableData &&
          other.id == this.id &&
          other.healthConditions == this.healthConditions &&
          other.medications == this.medications &&
          other.allergies == this.allergies &&
          other.notes == this.notes &&
          other.checkInCadenceHours == this.checkInCadenceHours &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class HealthProfilesTableCompanion
    extends UpdateCompanion<HealthProfilesTableData> {
  final Value<String> id;
  final Value<String> healthConditions;
  final Value<String> medications;
  final Value<String> allergies;
  final Value<String?> notes;
  final Value<int> checkInCadenceHours;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const HealthProfilesTableCompanion({
    this.id = const Value.absent(),
    this.healthConditions = const Value.absent(),
    this.medications = const Value.absent(),
    this.allergies = const Value.absent(),
    this.notes = const Value.absent(),
    this.checkInCadenceHours = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HealthProfilesTableCompanion.insert({
    required String id,
    this.healthConditions = const Value.absent(),
    this.medications = const Value.absent(),
    this.allergies = const Value.absent(),
    this.notes = const Value.absent(),
    this.checkInCadenceHours = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<HealthProfilesTableData> custom({
    Expression<String>? id,
    Expression<String>? healthConditions,
    Expression<String>? medications,
    Expression<String>? allergies,
    Expression<String>? notes,
    Expression<int>? checkInCadenceHours,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (healthConditions != null) 'health_conditions': healthConditions,
      if (medications != null) 'medications': medications,
      if (allergies != null) 'allergies': allergies,
      if (notes != null) 'notes': notes,
      if (checkInCadenceHours != null)
        'check_in_cadence_hours': checkInCadenceHours,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HealthProfilesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? healthConditions,
    Value<String>? medications,
    Value<String>? allergies,
    Value<String?>? notes,
    Value<int>? checkInCadenceHours,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return HealthProfilesTableCompanion(
      id: id ?? this.id,
      healthConditions: healthConditions ?? this.healthConditions,
      medications: medications ?? this.medications,
      allergies: allergies ?? this.allergies,
      notes: notes ?? this.notes,
      checkInCadenceHours: checkInCadenceHours ?? this.checkInCadenceHours,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (healthConditions.present) {
      map['health_conditions'] = Variable<String>(healthConditions.value);
    }
    if (medications.present) {
      map['medications'] = Variable<String>(medications.value);
    }
    if (allergies.present) {
      map['allergies'] = Variable<String>(allergies.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (checkInCadenceHours.present) {
      map['check_in_cadence_hours'] = Variable<int>(checkInCadenceHours.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HealthProfilesTableCompanion(')
          ..write('id: $id, ')
          ..write('healthConditions: $healthConditions, ')
          ..write('medications: $medications, ')
          ..write('allergies: $allergies, ')
          ..write('notes: $notes, ')
          ..write('checkInCadenceHours: $checkInCadenceHours, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HealthSyncRecordsTableTable extends HealthSyncRecordsTable
    with TableInfo<$HealthSyncRecordsTableTable, HealthSyncRecordsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HealthSyncRecordsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SyncSource, String> source =
      GeneratedColumn<String>(
        'source',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<SyncSource>(
        $HealthSyncRecordsTableTable.$convertersource,
      );
  static const VerificationMeta _recordTypeMeta = const VerificationMeta(
    'recordType',
  );
  @override
  late final GeneratedColumn<String> recordType = GeneratedColumn<String>(
    'record_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _externalIdMeta = const VerificationMeta(
    'externalId',
  );
  @override
  late final GeneratedColumn<String> externalId = GeneratedColumn<String>(
    'external_id',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 128,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recordedAtMeta = const VerificationMeta(
    'recordedAt',
  );
  @override
  late final GeneratedColumn<DateTime> recordedAt = GeneratedColumn<DateTime>(
    'recorded_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    source,
    recordType,
    externalId,
    payloadJson,
    recordedAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'health_sync_records_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<HealthSyncRecordsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('record_type')) {
      context.handle(
        _recordTypeMeta,
        recordType.isAcceptableOrUnknown(data['record_type']!, _recordTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_recordTypeMeta);
    }
    if (data.containsKey('external_id')) {
      context.handle(
        _externalIdMeta,
        externalId.isAcceptableOrUnknown(data['external_id']!, _externalIdMeta),
      );
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('recorded_at')) {
      context.handle(
        _recordedAtMeta,
        recordedAt.isAcceptableOrUnknown(data['recorded_at']!, _recordedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_recordedAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HealthSyncRecordsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HealthSyncRecordsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      source: $HealthSyncRecordsTableTable.$convertersource.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}source'],
        )!,
      ),
      recordType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}record_type'],
      )!,
      externalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}external_id'],
      ),
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
      recordedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}recorded_at'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $HealthSyncRecordsTableTable createAlias(String alias) {
    return $HealthSyncRecordsTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SyncSource, String, String> $convertersource =
      const EnumNameConverter<SyncSource>(SyncSource.values);
}

class HealthSyncRecordsTableData extends DataClass
    implements Insertable<HealthSyncRecordsTableData> {
  final String id;
  final SyncSource source;
  final String recordType;
  final String? externalId;
  final String payloadJson;
  final DateTime recordedAt;
  final DateTime createdAt;
  const HealthSyncRecordsTableData({
    required this.id,
    required this.source,
    required this.recordType,
    this.externalId,
    required this.payloadJson,
    required this.recordedAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    {
      map['source'] = Variable<String>(
        $HealthSyncRecordsTableTable.$convertersource.toSql(source),
      );
    }
    map['record_type'] = Variable<String>(recordType);
    if (!nullToAbsent || externalId != null) {
      map['external_id'] = Variable<String>(externalId);
    }
    map['payload_json'] = Variable<String>(payloadJson);
    map['recorded_at'] = Variable<DateTime>(recordedAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  HealthSyncRecordsTableCompanion toCompanion(bool nullToAbsent) {
    return HealthSyncRecordsTableCompanion(
      id: Value(id),
      source: Value(source),
      recordType: Value(recordType),
      externalId: externalId == null && nullToAbsent
          ? const Value.absent()
          : Value(externalId),
      payloadJson: Value(payloadJson),
      recordedAt: Value(recordedAt),
      createdAt: Value(createdAt),
    );
  }

  factory HealthSyncRecordsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HealthSyncRecordsTableData(
      id: serializer.fromJson<String>(json['id']),
      source: $HealthSyncRecordsTableTable.$convertersource.fromJson(
        serializer.fromJson<String>(json['source']),
      ),
      recordType: serializer.fromJson<String>(json['recordType']),
      externalId: serializer.fromJson<String?>(json['externalId']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      recordedAt: serializer.fromJson<DateTime>(json['recordedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'source': serializer.toJson<String>(
        $HealthSyncRecordsTableTable.$convertersource.toJson(source),
      ),
      'recordType': serializer.toJson<String>(recordType),
      'externalId': serializer.toJson<String?>(externalId),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'recordedAt': serializer.toJson<DateTime>(recordedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  HealthSyncRecordsTableData copyWith({
    String? id,
    SyncSource? source,
    String? recordType,
    Value<String?> externalId = const Value.absent(),
    String? payloadJson,
    DateTime? recordedAt,
    DateTime? createdAt,
  }) => HealthSyncRecordsTableData(
    id: id ?? this.id,
    source: source ?? this.source,
    recordType: recordType ?? this.recordType,
    externalId: externalId.present ? externalId.value : this.externalId,
    payloadJson: payloadJson ?? this.payloadJson,
    recordedAt: recordedAt ?? this.recordedAt,
    createdAt: createdAt ?? this.createdAt,
  );
  HealthSyncRecordsTableData copyWithCompanion(
    HealthSyncRecordsTableCompanion data,
  ) {
    return HealthSyncRecordsTableData(
      id: data.id.present ? data.id.value : this.id,
      source: data.source.present ? data.source.value : this.source,
      recordType: data.recordType.present
          ? data.recordType.value
          : this.recordType,
      externalId: data.externalId.present
          ? data.externalId.value
          : this.externalId,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      recordedAt: data.recordedAt.present
          ? data.recordedAt.value
          : this.recordedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HealthSyncRecordsTableData(')
          ..write('id: $id, ')
          ..write('source: $source, ')
          ..write('recordType: $recordType, ')
          ..write('externalId: $externalId, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    source,
    recordType,
    externalId,
    payloadJson,
    recordedAt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HealthSyncRecordsTableData &&
          other.id == this.id &&
          other.source == this.source &&
          other.recordType == this.recordType &&
          other.externalId == this.externalId &&
          other.payloadJson == this.payloadJson &&
          other.recordedAt == this.recordedAt &&
          other.createdAt == this.createdAt);
}

class HealthSyncRecordsTableCompanion
    extends UpdateCompanion<HealthSyncRecordsTableData> {
  final Value<String> id;
  final Value<SyncSource> source;
  final Value<String> recordType;
  final Value<String?> externalId;
  final Value<String> payloadJson;
  final Value<DateTime> recordedAt;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const HealthSyncRecordsTableCompanion({
    this.id = const Value.absent(),
    this.source = const Value.absent(),
    this.recordType = const Value.absent(),
    this.externalId = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.recordedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HealthSyncRecordsTableCompanion.insert({
    required String id,
    required SyncSource source,
    required String recordType,
    this.externalId = const Value.absent(),
    required String payloadJson,
    required DateTime recordedAt,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       source = Value(source),
       recordType = Value(recordType),
       payloadJson = Value(payloadJson),
       recordedAt = Value(recordedAt),
       createdAt = Value(createdAt);
  static Insertable<HealthSyncRecordsTableData> custom({
    Expression<String>? id,
    Expression<String>? source,
    Expression<String>? recordType,
    Expression<String>? externalId,
    Expression<String>? payloadJson,
    Expression<DateTime>? recordedAt,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (source != null) 'source': source,
      if (recordType != null) 'record_type': recordType,
      if (externalId != null) 'external_id': externalId,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (recordedAt != null) 'recorded_at': recordedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HealthSyncRecordsTableCompanion copyWith({
    Value<String>? id,
    Value<SyncSource>? source,
    Value<String>? recordType,
    Value<String?>? externalId,
    Value<String>? payloadJson,
    Value<DateTime>? recordedAt,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return HealthSyncRecordsTableCompanion(
      id: id ?? this.id,
      source: source ?? this.source,
      recordType: recordType ?? this.recordType,
      externalId: externalId ?? this.externalId,
      payloadJson: payloadJson ?? this.payloadJson,
      recordedAt: recordedAt ?? this.recordedAt,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(
        $HealthSyncRecordsTableTable.$convertersource.toSql(source.value),
      );
    }
    if (recordType.present) {
      map['record_type'] = Variable<String>(recordType.value);
    }
    if (externalId.present) {
      map['external_id'] = Variable<String>(externalId.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (recordedAt.present) {
      map['recorded_at'] = Variable<DateTime>(recordedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HealthSyncRecordsTableCompanion(')
          ..write('id: $id, ')
          ..write('source: $source, ')
          ..write('recordType: $recordType, ')
          ..write('externalId: $externalId, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HealthStatusLogsTableTable extends HealthStatusLogsTable
    with TableInfo<$HealthStatusLogsTableTable, HealthStatusLogsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HealthStatusLogsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<HealthEntryType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<HealthEntryType>(
        $HealthStatusLogsTableTable.$convertertype,
      );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _severityMeta = const VerificationMeta(
    'severity',
  );
  @override
  late final GeneratedColumn<int> severity = GeneratedColumn<int>(
    'severity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _loggedAtMeta = const VerificationMeta(
    'loggedAt',
  );
  @override
  late final GeneratedColumn<DateTime> loggedAt = GeneratedColumn<DateTime>(
    'logged_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _resolvedAtMeta = const VerificationMeta(
    'resolvedAt',
  );
  @override
  late final GeneratedColumn<DateTime> resolvedAt = GeneratedColumn<DateTime>(
    'resolved_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _energyLevelMeta = const VerificationMeta(
    'energyLevel',
  );
  @override
  late final GeneratedColumn<int> energyLevel = GeneratedColumn<int>(
    'energy_level',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bodyAreaMeta = const VerificationMeta(
    'bodyArea',
  );
  @override
  late final GeneratedColumn<String> bodyArea = GeneratedColumn<String>(
    'body_area',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _symptomTagsMeta = const VerificationMeta(
    'symptomTags',
  );
  @override
  late final GeneratedColumn<String> symptomTags = GeneratedColumn<String>(
    'symptom_tags',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _possibleTriggerMeta = const VerificationMeta(
    'possibleTrigger',
  );
  @override
  late final GeneratedColumn<String> possibleTrigger = GeneratedColumn<String>(
    'possible_trigger',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 160,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    title,
    severity,
    loggedAt,
    startedAt,
    resolvedAt,
    energyLevel,
    bodyArea,
    symptomTags,
    possibleTrigger,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'health_status_logs_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<HealthStatusLogsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('severity')) {
      context.handle(
        _severityMeta,
        severity.isAcceptableOrUnknown(data['severity']!, _severityMeta),
      );
    } else if (isInserting) {
      context.missing(_severityMeta);
    }
    if (data.containsKey('logged_at')) {
      context.handle(
        _loggedAtMeta,
        loggedAt.isAcceptableOrUnknown(data['logged_at']!, _loggedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_loggedAtMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    }
    if (data.containsKey('resolved_at')) {
      context.handle(
        _resolvedAtMeta,
        resolvedAt.isAcceptableOrUnknown(data['resolved_at']!, _resolvedAtMeta),
      );
    }
    if (data.containsKey('energy_level')) {
      context.handle(
        _energyLevelMeta,
        energyLevel.isAcceptableOrUnknown(
          data['energy_level']!,
          _energyLevelMeta,
        ),
      );
    }
    if (data.containsKey('body_area')) {
      context.handle(
        _bodyAreaMeta,
        bodyArea.isAcceptableOrUnknown(data['body_area']!, _bodyAreaMeta),
      );
    }
    if (data.containsKey('symptom_tags')) {
      context.handle(
        _symptomTagsMeta,
        symptomTags.isAcceptableOrUnknown(
          data['symptom_tags']!,
          _symptomTagsMeta,
        ),
      );
    }
    if (data.containsKey('possible_trigger')) {
      context.handle(
        _possibleTriggerMeta,
        possibleTrigger.isAcceptableOrUnknown(
          data['possible_trigger']!,
          _possibleTriggerMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HealthStatusLogsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HealthStatusLogsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      type: $HealthStatusLogsTableTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      severity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}severity'],
      )!,
      loggedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}logged_at'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      ),
      resolvedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}resolved_at'],
      ),
      energyLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}energy_level'],
      ),
      bodyArea: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body_area'],
      ),
      symptomTags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}symptom_tags'],
      )!,
      possibleTrigger: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}possible_trigger'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $HealthStatusLogsTableTable createAlias(String alias) {
    return $HealthStatusLogsTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<HealthEntryType, String, String> $convertertype =
      const EnumNameConverter<HealthEntryType>(HealthEntryType.values);
}

class HealthStatusLogsTableData extends DataClass
    implements Insertable<HealthStatusLogsTableData> {
  final String id;
  final HealthEntryType type;
  final String title;
  final int severity;
  final DateTime loggedAt;
  final DateTime? startedAt;
  final DateTime? resolvedAt;
  final int? energyLevel;
  final String? bodyArea;
  final String symptomTags;
  final String? possibleTrigger;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const HealthStatusLogsTableData({
    required this.id,
    required this.type,
    required this.title,
    required this.severity,
    required this.loggedAt,
    this.startedAt,
    this.resolvedAt,
    this.energyLevel,
    this.bodyArea,
    required this.symptomTags,
    this.possibleTrigger,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    {
      map['type'] = Variable<String>(
        $HealthStatusLogsTableTable.$convertertype.toSql(type),
      );
    }
    map['title'] = Variable<String>(title);
    map['severity'] = Variable<int>(severity);
    map['logged_at'] = Variable<DateTime>(loggedAt);
    if (!nullToAbsent || startedAt != null) {
      map['started_at'] = Variable<DateTime>(startedAt);
    }
    if (!nullToAbsent || resolvedAt != null) {
      map['resolved_at'] = Variable<DateTime>(resolvedAt);
    }
    if (!nullToAbsent || energyLevel != null) {
      map['energy_level'] = Variable<int>(energyLevel);
    }
    if (!nullToAbsent || bodyArea != null) {
      map['body_area'] = Variable<String>(bodyArea);
    }
    map['symptom_tags'] = Variable<String>(symptomTags);
    if (!nullToAbsent || possibleTrigger != null) {
      map['possible_trigger'] = Variable<String>(possibleTrigger);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  HealthStatusLogsTableCompanion toCompanion(bool nullToAbsent) {
    return HealthStatusLogsTableCompanion(
      id: Value(id),
      type: Value(type),
      title: Value(title),
      severity: Value(severity),
      loggedAt: Value(loggedAt),
      startedAt: startedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(startedAt),
      resolvedAt: resolvedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(resolvedAt),
      energyLevel: energyLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(energyLevel),
      bodyArea: bodyArea == null && nullToAbsent
          ? const Value.absent()
          : Value(bodyArea),
      symptomTags: Value(symptomTags),
      possibleTrigger: possibleTrigger == null && nullToAbsent
          ? const Value.absent()
          : Value(possibleTrigger),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory HealthStatusLogsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HealthStatusLogsTableData(
      id: serializer.fromJson<String>(json['id']),
      type: $HealthStatusLogsTableTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      title: serializer.fromJson<String>(json['title']),
      severity: serializer.fromJson<int>(json['severity']),
      loggedAt: serializer.fromJson<DateTime>(json['loggedAt']),
      startedAt: serializer.fromJson<DateTime?>(json['startedAt']),
      resolvedAt: serializer.fromJson<DateTime?>(json['resolvedAt']),
      energyLevel: serializer.fromJson<int?>(json['energyLevel']),
      bodyArea: serializer.fromJson<String?>(json['bodyArea']),
      symptomTags: serializer.fromJson<String>(json['symptomTags']),
      possibleTrigger: serializer.fromJson<String?>(json['possibleTrigger']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(
        $HealthStatusLogsTableTable.$convertertype.toJson(type),
      ),
      'title': serializer.toJson<String>(title),
      'severity': serializer.toJson<int>(severity),
      'loggedAt': serializer.toJson<DateTime>(loggedAt),
      'startedAt': serializer.toJson<DateTime?>(startedAt),
      'resolvedAt': serializer.toJson<DateTime?>(resolvedAt),
      'energyLevel': serializer.toJson<int?>(energyLevel),
      'bodyArea': serializer.toJson<String?>(bodyArea),
      'symptomTags': serializer.toJson<String>(symptomTags),
      'possibleTrigger': serializer.toJson<String?>(possibleTrigger),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  HealthStatusLogsTableData copyWith({
    String? id,
    HealthEntryType? type,
    String? title,
    int? severity,
    DateTime? loggedAt,
    Value<DateTime?> startedAt = const Value.absent(),
    Value<DateTime?> resolvedAt = const Value.absent(),
    Value<int?> energyLevel = const Value.absent(),
    Value<String?> bodyArea = const Value.absent(),
    String? symptomTags,
    Value<String?> possibleTrigger = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => HealthStatusLogsTableData(
    id: id ?? this.id,
    type: type ?? this.type,
    title: title ?? this.title,
    severity: severity ?? this.severity,
    loggedAt: loggedAt ?? this.loggedAt,
    startedAt: startedAt.present ? startedAt.value : this.startedAt,
    resolvedAt: resolvedAt.present ? resolvedAt.value : this.resolvedAt,
    energyLevel: energyLevel.present ? energyLevel.value : this.energyLevel,
    bodyArea: bodyArea.present ? bodyArea.value : this.bodyArea,
    symptomTags: symptomTags ?? this.symptomTags,
    possibleTrigger: possibleTrigger.present
        ? possibleTrigger.value
        : this.possibleTrigger,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  HealthStatusLogsTableData copyWithCompanion(
    HealthStatusLogsTableCompanion data,
  ) {
    return HealthStatusLogsTableData(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      title: data.title.present ? data.title.value : this.title,
      severity: data.severity.present ? data.severity.value : this.severity,
      loggedAt: data.loggedAt.present ? data.loggedAt.value : this.loggedAt,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      resolvedAt: data.resolvedAt.present
          ? data.resolvedAt.value
          : this.resolvedAt,
      energyLevel: data.energyLevel.present
          ? data.energyLevel.value
          : this.energyLevel,
      bodyArea: data.bodyArea.present ? data.bodyArea.value : this.bodyArea,
      symptomTags: data.symptomTags.present
          ? data.symptomTags.value
          : this.symptomTags,
      possibleTrigger: data.possibleTrigger.present
          ? data.possibleTrigger.value
          : this.possibleTrigger,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HealthStatusLogsTableData(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('severity: $severity, ')
          ..write('loggedAt: $loggedAt, ')
          ..write('startedAt: $startedAt, ')
          ..write('resolvedAt: $resolvedAt, ')
          ..write('energyLevel: $energyLevel, ')
          ..write('bodyArea: $bodyArea, ')
          ..write('symptomTags: $symptomTags, ')
          ..write('possibleTrigger: $possibleTrigger, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    type,
    title,
    severity,
    loggedAt,
    startedAt,
    resolvedAt,
    energyLevel,
    bodyArea,
    symptomTags,
    possibleTrigger,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HealthStatusLogsTableData &&
          other.id == this.id &&
          other.type == this.type &&
          other.title == this.title &&
          other.severity == this.severity &&
          other.loggedAt == this.loggedAt &&
          other.startedAt == this.startedAt &&
          other.resolvedAt == this.resolvedAt &&
          other.energyLevel == this.energyLevel &&
          other.bodyArea == this.bodyArea &&
          other.symptomTags == this.symptomTags &&
          other.possibleTrigger == this.possibleTrigger &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class HealthStatusLogsTableCompanion
    extends UpdateCompanion<HealthStatusLogsTableData> {
  final Value<String> id;
  final Value<HealthEntryType> type;
  final Value<String> title;
  final Value<int> severity;
  final Value<DateTime> loggedAt;
  final Value<DateTime?> startedAt;
  final Value<DateTime?> resolvedAt;
  final Value<int?> energyLevel;
  final Value<String?> bodyArea;
  final Value<String> symptomTags;
  final Value<String?> possibleTrigger;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const HealthStatusLogsTableCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.title = const Value.absent(),
    this.severity = const Value.absent(),
    this.loggedAt = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.resolvedAt = const Value.absent(),
    this.energyLevel = const Value.absent(),
    this.bodyArea = const Value.absent(),
    this.symptomTags = const Value.absent(),
    this.possibleTrigger = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HealthStatusLogsTableCompanion.insert({
    required String id,
    required HealthEntryType type,
    required String title,
    required int severity,
    required DateTime loggedAt,
    this.startedAt = const Value.absent(),
    this.resolvedAt = const Value.absent(),
    this.energyLevel = const Value.absent(),
    this.bodyArea = const Value.absent(),
    this.symptomTags = const Value.absent(),
    this.possibleTrigger = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       type = Value(type),
       title = Value(title),
       severity = Value(severity),
       loggedAt = Value(loggedAt),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<HealthStatusLogsTableData> custom({
    Expression<String>? id,
    Expression<String>? type,
    Expression<String>? title,
    Expression<int>? severity,
    Expression<DateTime>? loggedAt,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? resolvedAt,
    Expression<int>? energyLevel,
    Expression<String>? bodyArea,
    Expression<String>? symptomTags,
    Expression<String>? possibleTrigger,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (title != null) 'title': title,
      if (severity != null) 'severity': severity,
      if (loggedAt != null) 'logged_at': loggedAt,
      if (startedAt != null) 'started_at': startedAt,
      if (resolvedAt != null) 'resolved_at': resolvedAt,
      if (energyLevel != null) 'energy_level': energyLevel,
      if (bodyArea != null) 'body_area': bodyArea,
      if (symptomTags != null) 'symptom_tags': symptomTags,
      if (possibleTrigger != null) 'possible_trigger': possibleTrigger,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HealthStatusLogsTableCompanion copyWith({
    Value<String>? id,
    Value<HealthEntryType>? type,
    Value<String>? title,
    Value<int>? severity,
    Value<DateTime>? loggedAt,
    Value<DateTime?>? startedAt,
    Value<DateTime?>? resolvedAt,
    Value<int?>? energyLevel,
    Value<String?>? bodyArea,
    Value<String>? symptomTags,
    Value<String?>? possibleTrigger,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return HealthStatusLogsTableCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      severity: severity ?? this.severity,
      loggedAt: loggedAt ?? this.loggedAt,
      startedAt: startedAt ?? this.startedAt,
      resolvedAt: resolvedAt ?? this.resolvedAt,
      energyLevel: energyLevel ?? this.energyLevel,
      bodyArea: bodyArea ?? this.bodyArea,
      symptomTags: symptomTags ?? this.symptomTags,
      possibleTrigger: possibleTrigger ?? this.possibleTrigger,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $HealthStatusLogsTableTable.$convertertype.toSql(type.value),
      );
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (severity.present) {
      map['severity'] = Variable<int>(severity.value);
    }
    if (loggedAt.present) {
      map['logged_at'] = Variable<DateTime>(loggedAt.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (resolvedAt.present) {
      map['resolved_at'] = Variable<DateTime>(resolvedAt.value);
    }
    if (energyLevel.present) {
      map['energy_level'] = Variable<int>(energyLevel.value);
    }
    if (bodyArea.present) {
      map['body_area'] = Variable<String>(bodyArea.value);
    }
    if (symptomTags.present) {
      map['symptom_tags'] = Variable<String>(symptomTags.value);
    }
    if (possibleTrigger.present) {
      map['possible_trigger'] = Variable<String>(possibleTrigger.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HealthStatusLogsTableCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('severity: $severity, ')
          ..write('loggedAt: $loggedAt, ')
          ..write('startedAt: $startedAt, ')
          ..write('resolvedAt: $resolvedAt, ')
          ..write('energyLevel: $energyLevel, ')
          ..write('bodyArea: $bodyArea, ')
          ..write('symptomTags: $symptomTags, ')
          ..write('possibleTrigger: $possibleTrigger, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InsightsTableTable extends InsightsTable
    with TableInfo<$InsightsTableTable, InsightsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InsightsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<InsightCategory, String>
  category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<InsightCategory>($InsightsTableTable.$convertercategory);
  @override
  late final GeneratedColumnWithTypeConverter<InsightSeverity, String>
  severity = GeneratedColumn<String>(
    'severity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<InsightSeverity>($InsightsTableTable.$converterseverity);
  @override
  late final GeneratedColumnWithTypeConverter<InsightStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<InsightStatus>($InsightsTableTable.$converterstatus);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 160,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shortMessageMeta = const VerificationMeta(
    'shortMessage',
  );
  @override
  late final GeneratedColumn<String> shortMessage = GeneratedColumn<String>(
    'short_message',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 280,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fullExplanationMeta = const VerificationMeta(
    'fullExplanation',
  );
  @override
  late final GeneratedColumn<String> fullExplanation = GeneratedColumn<String>(
    'full_explanation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _evidenceJsonMeta = const VerificationMeta(
    'evidenceJson',
  );
  @override
  late final GeneratedColumn<String> evidenceJson = GeneratedColumn<String>(
    'evidence_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _suggestedActionMeta = const VerificationMeta(
    'suggestedAction',
  );
  @override
  late final GeneratedColumn<String> suggestedAction = GeneratedColumn<String>(
    'suggested_action',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    category,
    severity,
    status,
    title,
    shortMessage,
    fullExplanation,
    evidenceJson,
    confidence,
    suggestedAction,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'insights_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<InsightsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('short_message')) {
      context.handle(
        _shortMessageMeta,
        shortMessage.isAcceptableOrUnknown(
          data['short_message']!,
          _shortMessageMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_shortMessageMeta);
    }
    if (data.containsKey('full_explanation')) {
      context.handle(
        _fullExplanationMeta,
        fullExplanation.isAcceptableOrUnknown(
          data['full_explanation']!,
          _fullExplanationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fullExplanationMeta);
    }
    if (data.containsKey('evidence_json')) {
      context.handle(
        _evidenceJsonMeta,
        evidenceJson.isAcceptableOrUnknown(
          data['evidence_json']!,
          _evidenceJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_evidenceJsonMeta);
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    } else if (isInserting) {
      context.missing(_confidenceMeta);
    }
    if (data.containsKey('suggested_action')) {
      context.handle(
        _suggestedActionMeta,
        suggestedAction.isAcceptableOrUnknown(
          data['suggested_action']!,
          _suggestedActionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_suggestedActionMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InsightsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InsightsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      category: $InsightsTableTable.$convertercategory.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}category'],
        )!,
      ),
      severity: $InsightsTableTable.$converterseverity.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}severity'],
        )!,
      ),
      status: $InsightsTableTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      shortMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}short_message'],
      )!,
      fullExplanation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_explanation'],
      )!,
      evidenceJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}evidence_json'],
      )!,
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence'],
      )!,
      suggestedAction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}suggested_action'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $InsightsTableTable createAlias(String alias) {
    return $InsightsTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<InsightCategory, String, String>
  $convertercategory = const EnumNameConverter<InsightCategory>(
    InsightCategory.values,
  );
  static JsonTypeConverter2<InsightSeverity, String, String>
  $converterseverity = const EnumNameConverter<InsightSeverity>(
    InsightSeverity.values,
  );
  static JsonTypeConverter2<InsightStatus, String, String> $converterstatus =
      const EnumNameConverter<InsightStatus>(InsightStatus.values);
}

class InsightsTableData extends DataClass
    implements Insertable<InsightsTableData> {
  final String id;
  final InsightCategory category;
  final InsightSeverity severity;
  final InsightStatus status;
  final String title;
  final String shortMessage;
  final String fullExplanation;
  final String evidenceJson;
  final double confidence;
  final String suggestedAction;
  final DateTime createdAt;
  final DateTime updatedAt;
  const InsightsTableData({
    required this.id,
    required this.category,
    required this.severity,
    required this.status,
    required this.title,
    required this.shortMessage,
    required this.fullExplanation,
    required this.evidenceJson,
    required this.confidence,
    required this.suggestedAction,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    {
      map['category'] = Variable<String>(
        $InsightsTableTable.$convertercategory.toSql(category),
      );
    }
    {
      map['severity'] = Variable<String>(
        $InsightsTableTable.$converterseverity.toSql(severity),
      );
    }
    {
      map['status'] = Variable<String>(
        $InsightsTableTable.$converterstatus.toSql(status),
      );
    }
    map['title'] = Variable<String>(title);
    map['short_message'] = Variable<String>(shortMessage);
    map['full_explanation'] = Variable<String>(fullExplanation);
    map['evidence_json'] = Variable<String>(evidenceJson);
    map['confidence'] = Variable<double>(confidence);
    map['suggested_action'] = Variable<String>(suggestedAction);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  InsightsTableCompanion toCompanion(bool nullToAbsent) {
    return InsightsTableCompanion(
      id: Value(id),
      category: Value(category),
      severity: Value(severity),
      status: Value(status),
      title: Value(title),
      shortMessage: Value(shortMessage),
      fullExplanation: Value(fullExplanation),
      evidenceJson: Value(evidenceJson),
      confidence: Value(confidence),
      suggestedAction: Value(suggestedAction),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory InsightsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InsightsTableData(
      id: serializer.fromJson<String>(json['id']),
      category: $InsightsTableTable.$convertercategory.fromJson(
        serializer.fromJson<String>(json['category']),
      ),
      severity: $InsightsTableTable.$converterseverity.fromJson(
        serializer.fromJson<String>(json['severity']),
      ),
      status: $InsightsTableTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      title: serializer.fromJson<String>(json['title']),
      shortMessage: serializer.fromJson<String>(json['shortMessage']),
      fullExplanation: serializer.fromJson<String>(json['fullExplanation']),
      evidenceJson: serializer.fromJson<String>(json['evidenceJson']),
      confidence: serializer.fromJson<double>(json['confidence']),
      suggestedAction: serializer.fromJson<String>(json['suggestedAction']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'category': serializer.toJson<String>(
        $InsightsTableTable.$convertercategory.toJson(category),
      ),
      'severity': serializer.toJson<String>(
        $InsightsTableTable.$converterseverity.toJson(severity),
      ),
      'status': serializer.toJson<String>(
        $InsightsTableTable.$converterstatus.toJson(status),
      ),
      'title': serializer.toJson<String>(title),
      'shortMessage': serializer.toJson<String>(shortMessage),
      'fullExplanation': serializer.toJson<String>(fullExplanation),
      'evidenceJson': serializer.toJson<String>(evidenceJson),
      'confidence': serializer.toJson<double>(confidence),
      'suggestedAction': serializer.toJson<String>(suggestedAction),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  InsightsTableData copyWith({
    String? id,
    InsightCategory? category,
    InsightSeverity? severity,
    InsightStatus? status,
    String? title,
    String? shortMessage,
    String? fullExplanation,
    String? evidenceJson,
    double? confidence,
    String? suggestedAction,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => InsightsTableData(
    id: id ?? this.id,
    category: category ?? this.category,
    severity: severity ?? this.severity,
    status: status ?? this.status,
    title: title ?? this.title,
    shortMessage: shortMessage ?? this.shortMessage,
    fullExplanation: fullExplanation ?? this.fullExplanation,
    evidenceJson: evidenceJson ?? this.evidenceJson,
    confidence: confidence ?? this.confidence,
    suggestedAction: suggestedAction ?? this.suggestedAction,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  InsightsTableData copyWithCompanion(InsightsTableCompanion data) {
    return InsightsTableData(
      id: data.id.present ? data.id.value : this.id,
      category: data.category.present ? data.category.value : this.category,
      severity: data.severity.present ? data.severity.value : this.severity,
      status: data.status.present ? data.status.value : this.status,
      title: data.title.present ? data.title.value : this.title,
      shortMessage: data.shortMessage.present
          ? data.shortMessage.value
          : this.shortMessage,
      fullExplanation: data.fullExplanation.present
          ? data.fullExplanation.value
          : this.fullExplanation,
      evidenceJson: data.evidenceJson.present
          ? data.evidenceJson.value
          : this.evidenceJson,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      suggestedAction: data.suggestedAction.present
          ? data.suggestedAction.value
          : this.suggestedAction,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InsightsTableData(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('severity: $severity, ')
          ..write('status: $status, ')
          ..write('title: $title, ')
          ..write('shortMessage: $shortMessage, ')
          ..write('fullExplanation: $fullExplanation, ')
          ..write('evidenceJson: $evidenceJson, ')
          ..write('confidence: $confidence, ')
          ..write('suggestedAction: $suggestedAction, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    category,
    severity,
    status,
    title,
    shortMessage,
    fullExplanation,
    evidenceJson,
    confidence,
    suggestedAction,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InsightsTableData &&
          other.id == this.id &&
          other.category == this.category &&
          other.severity == this.severity &&
          other.status == this.status &&
          other.title == this.title &&
          other.shortMessage == this.shortMessage &&
          other.fullExplanation == this.fullExplanation &&
          other.evidenceJson == this.evidenceJson &&
          other.confidence == this.confidence &&
          other.suggestedAction == this.suggestedAction &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class InsightsTableCompanion extends UpdateCompanion<InsightsTableData> {
  final Value<String> id;
  final Value<InsightCategory> category;
  final Value<InsightSeverity> severity;
  final Value<InsightStatus> status;
  final Value<String> title;
  final Value<String> shortMessage;
  final Value<String> fullExplanation;
  final Value<String> evidenceJson;
  final Value<double> confidence;
  final Value<String> suggestedAction;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const InsightsTableCompanion({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
    this.severity = const Value.absent(),
    this.status = const Value.absent(),
    this.title = const Value.absent(),
    this.shortMessage = const Value.absent(),
    this.fullExplanation = const Value.absent(),
    this.evidenceJson = const Value.absent(),
    this.confidence = const Value.absent(),
    this.suggestedAction = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InsightsTableCompanion.insert({
    required String id,
    required InsightCategory category,
    required InsightSeverity severity,
    required InsightStatus status,
    required String title,
    required String shortMessage,
    required String fullExplanation,
    required String evidenceJson,
    required double confidence,
    required String suggestedAction,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       category = Value(category),
       severity = Value(severity),
       status = Value(status),
       title = Value(title),
       shortMessage = Value(shortMessage),
       fullExplanation = Value(fullExplanation),
       evidenceJson = Value(evidenceJson),
       confidence = Value(confidence),
       suggestedAction = Value(suggestedAction),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<InsightsTableData> custom({
    Expression<String>? id,
    Expression<String>? category,
    Expression<String>? severity,
    Expression<String>? status,
    Expression<String>? title,
    Expression<String>? shortMessage,
    Expression<String>? fullExplanation,
    Expression<String>? evidenceJson,
    Expression<double>? confidence,
    Expression<String>? suggestedAction,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (category != null) 'category': category,
      if (severity != null) 'severity': severity,
      if (status != null) 'status': status,
      if (title != null) 'title': title,
      if (shortMessage != null) 'short_message': shortMessage,
      if (fullExplanation != null) 'full_explanation': fullExplanation,
      if (evidenceJson != null) 'evidence_json': evidenceJson,
      if (confidence != null) 'confidence': confidence,
      if (suggestedAction != null) 'suggested_action': suggestedAction,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InsightsTableCompanion copyWith({
    Value<String>? id,
    Value<InsightCategory>? category,
    Value<InsightSeverity>? severity,
    Value<InsightStatus>? status,
    Value<String>? title,
    Value<String>? shortMessage,
    Value<String>? fullExplanation,
    Value<String>? evidenceJson,
    Value<double>? confidence,
    Value<String>? suggestedAction,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return InsightsTableCompanion(
      id: id ?? this.id,
      category: category ?? this.category,
      severity: severity ?? this.severity,
      status: status ?? this.status,
      title: title ?? this.title,
      shortMessage: shortMessage ?? this.shortMessage,
      fullExplanation: fullExplanation ?? this.fullExplanation,
      evidenceJson: evidenceJson ?? this.evidenceJson,
      confidence: confidence ?? this.confidence,
      suggestedAction: suggestedAction ?? this.suggestedAction,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(
        $InsightsTableTable.$convertercategory.toSql(category.value),
      );
    }
    if (severity.present) {
      map['severity'] = Variable<String>(
        $InsightsTableTable.$converterseverity.toSql(severity.value),
      );
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $InsightsTableTable.$converterstatus.toSql(status.value),
      );
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (shortMessage.present) {
      map['short_message'] = Variable<String>(shortMessage.value);
    }
    if (fullExplanation.present) {
      map['full_explanation'] = Variable<String>(fullExplanation.value);
    }
    if (evidenceJson.present) {
      map['evidence_json'] = Variable<String>(evidenceJson.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (suggestedAction.present) {
      map['suggested_action'] = Variable<String>(suggestedAction.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InsightsTableCompanion(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('severity: $severity, ')
          ..write('status: $status, ')
          ..write('title: $title, ')
          ..write('shortMessage: $shortMessage, ')
          ..write('fullExplanation: $fullExplanation, ')
          ..write('evidenceJson: $evidenceJson, ')
          ..write('confidence: $confidence, ')
          ..write('suggestedAction: $suggestedAction, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTableTable extends AppSettingsTable
    with TableInfo<$AppSettingsTableTable, AppSettingsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSettingsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppSettingsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSettingsTableData(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AppSettingsTableTable createAlias(String alias) {
    return $AppSettingsTableTable(attachedDatabase, alias);
  }
}

class AppSettingsTableData extends DataClass
    implements Insertable<AppSettingsTableData> {
  final String key;
  final String value;
  final DateTime updatedAt;
  const AppSettingsTableData({
    required this.key,
    required this.value,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AppSettingsTableCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsTableCompanion(
      key: Value(key),
      value: Value(value),
      updatedAt: Value(updatedAt),
    );
  }

  factory AppSettingsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSettingsTableData(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AppSettingsTableData copyWith({
    String? key,
    String? value,
    DateTime? updatedAt,
  }) => AppSettingsTableData(
    key: key ?? this.key,
    value: value ?? this.value,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AppSettingsTableData copyWithCompanion(AppSettingsTableCompanion data) {
    return AppSettingsTableData(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsTableData(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSettingsTableData &&
          other.key == this.key &&
          other.value == this.value &&
          other.updatedAt == this.updatedAt);
}

class AppSettingsTableCompanion extends UpdateCompanion<AppSettingsTableData> {
  final Value<String> key;
  final Value<String> value;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AppSettingsTableCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsTableCompanion.insert({
    required String key,
    required String value,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value),
       updatedAt = Value(updatedAt);
  static Insertable<AppSettingsTableData> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsTableCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return AppSettingsTableCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsTableCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueTableTable extends SyncQueueTable
    with TableInfo<$SyncQueueTableTable, SyncQueueTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 128,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SyncDomain, String> domain =
      GeneratedColumn<String>(
        'domain',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<SyncDomain>($SyncQueueTableTable.$converterdomain);
  @override
  late final GeneratedColumnWithTypeConverter<SyncQueueOperation, String>
  operation = GeneratedColumn<String>(
    'operation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<SyncQueueOperation>($SyncQueueTableTable.$converteroperation);
  @override
  late final GeneratedColumnWithTypeConverter<SyncQueueStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('pending'),
      ).withConverter<SyncQueueStatus>($SyncQueueTableTable.$converterstatus);
  static const VerificationMeta _queuedAtMeta = const VerificationMeta(
    'queuedAt',
  );
  @override
  late final GeneratedColumn<DateTime> queuedAt = GeneratedColumn<DateTime>(
    'queued_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastAttemptAtMeta = const VerificationMeta(
    'lastAttemptAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastAttemptAt =
      GeneratedColumn<DateTime>(
        'last_attempt_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastSuccessAtMeta = const VerificationMeta(
    'lastSuccessAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSuccessAt =
      GeneratedColumn<DateTime>(
        'last_success_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _retryCountMeta = const VerificationMeta(
    'retryCount',
  );
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
    'retry_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    accountId,
    domain,
    operation,
    status,
    queuedAt,
    updatedAt,
    lastAttemptAt,
    lastSuccessAt,
    lastError,
    retryCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncQueueTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('queued_at')) {
      context.handle(
        _queuedAtMeta,
        queuedAt.isAcceptableOrUnknown(data['queued_at']!, _queuedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_queuedAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('last_attempt_at')) {
      context.handle(
        _lastAttemptAtMeta,
        lastAttemptAt.isAcceptableOrUnknown(
          data['last_attempt_at']!,
          _lastAttemptAtMeta,
        ),
      );
    }
    if (data.containsKey('last_success_at')) {
      context.handle(
        _lastSuccessAtMeta,
        lastSuccessAt.isAcceptableOrUnknown(
          data['last_success_at']!,
          _lastSuccessAtMeta,
        ),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    if (data.containsKey('retry_count')) {
      context.handle(
        _retryCountMeta,
        retryCount.isAcceptableOrUnknown(data['retry_count']!, _retryCountMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {accountId, domain, operation};
  @override
  SyncQueueTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueTableData(
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      domain: $SyncQueueTableTable.$converterdomain.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}domain'],
        )!,
      ),
      operation: $SyncQueueTableTable.$converteroperation.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}operation'],
        )!,
      ),
      status: $SyncQueueTableTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      queuedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}queued_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      lastAttemptAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_attempt_at'],
      ),
      lastSuccessAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_success_at'],
      ),
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
      retryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retry_count'],
      )!,
    );
  }

  @override
  $SyncQueueTableTable createAlias(String alias) {
    return $SyncQueueTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SyncDomain, String, String> $converterdomain =
      const EnumNameConverter<SyncDomain>(SyncDomain.values);
  static JsonTypeConverter2<SyncQueueOperation, String, String>
  $converteroperation = const EnumNameConverter<SyncQueueOperation>(
    SyncQueueOperation.values,
  );
  static JsonTypeConverter2<SyncQueueStatus, String, String> $converterstatus =
      const EnumNameConverter<SyncQueueStatus>(SyncQueueStatus.values);
}

class SyncQueueTableData extends DataClass
    implements Insertable<SyncQueueTableData> {
  final String accountId;
  final SyncDomain domain;
  final SyncQueueOperation operation;
  final SyncQueueStatus status;
  final DateTime queuedAt;
  final DateTime updatedAt;
  final DateTime? lastAttemptAt;
  final DateTime? lastSuccessAt;
  final String? lastError;
  final int retryCount;
  const SyncQueueTableData({
    required this.accountId,
    required this.domain,
    required this.operation,
    required this.status,
    required this.queuedAt,
    required this.updatedAt,
    this.lastAttemptAt,
    this.lastSuccessAt,
    this.lastError,
    required this.retryCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['account_id'] = Variable<String>(accountId);
    {
      map['domain'] = Variable<String>(
        $SyncQueueTableTable.$converterdomain.toSql(domain),
      );
    }
    {
      map['operation'] = Variable<String>(
        $SyncQueueTableTable.$converteroperation.toSql(operation),
      );
    }
    {
      map['status'] = Variable<String>(
        $SyncQueueTableTable.$converterstatus.toSql(status),
      );
    }
    map['queued_at'] = Variable<DateTime>(queuedAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || lastAttemptAt != null) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt);
    }
    if (!nullToAbsent || lastSuccessAt != null) {
      map['last_success_at'] = Variable<DateTime>(lastSuccessAt);
    }
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    map['retry_count'] = Variable<int>(retryCount);
    return map;
  }

  SyncQueueTableCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueTableCompanion(
      accountId: Value(accountId),
      domain: Value(domain),
      operation: Value(operation),
      status: Value(status),
      queuedAt: Value(queuedAt),
      updatedAt: Value(updatedAt),
      lastAttemptAt: lastAttemptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAttemptAt),
      lastSuccessAt: lastSuccessAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSuccessAt),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
      retryCount: Value(retryCount),
    );
  }

  factory SyncQueueTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueTableData(
      accountId: serializer.fromJson<String>(json['accountId']),
      domain: $SyncQueueTableTable.$converterdomain.fromJson(
        serializer.fromJson<String>(json['domain']),
      ),
      operation: $SyncQueueTableTable.$converteroperation.fromJson(
        serializer.fromJson<String>(json['operation']),
      ),
      status: $SyncQueueTableTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      queuedAt: serializer.fromJson<DateTime>(json['queuedAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      lastAttemptAt: serializer.fromJson<DateTime?>(json['lastAttemptAt']),
      lastSuccessAt: serializer.fromJson<DateTime?>(json['lastSuccessAt']),
      lastError: serializer.fromJson<String?>(json['lastError']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'accountId': serializer.toJson<String>(accountId),
      'domain': serializer.toJson<String>(
        $SyncQueueTableTable.$converterdomain.toJson(domain),
      ),
      'operation': serializer.toJson<String>(
        $SyncQueueTableTable.$converteroperation.toJson(operation),
      ),
      'status': serializer.toJson<String>(
        $SyncQueueTableTable.$converterstatus.toJson(status),
      ),
      'queuedAt': serializer.toJson<DateTime>(queuedAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'lastAttemptAt': serializer.toJson<DateTime?>(lastAttemptAt),
      'lastSuccessAt': serializer.toJson<DateTime?>(lastSuccessAt),
      'lastError': serializer.toJson<String?>(lastError),
      'retryCount': serializer.toJson<int>(retryCount),
    };
  }

  SyncQueueTableData copyWith({
    String? accountId,
    SyncDomain? domain,
    SyncQueueOperation? operation,
    SyncQueueStatus? status,
    DateTime? queuedAt,
    DateTime? updatedAt,
    Value<DateTime?> lastAttemptAt = const Value.absent(),
    Value<DateTime?> lastSuccessAt = const Value.absent(),
    Value<String?> lastError = const Value.absent(),
    int? retryCount,
  }) => SyncQueueTableData(
    accountId: accountId ?? this.accountId,
    domain: domain ?? this.domain,
    operation: operation ?? this.operation,
    status: status ?? this.status,
    queuedAt: queuedAt ?? this.queuedAt,
    updatedAt: updatedAt ?? this.updatedAt,
    lastAttemptAt: lastAttemptAt.present
        ? lastAttemptAt.value
        : this.lastAttemptAt,
    lastSuccessAt: lastSuccessAt.present
        ? lastSuccessAt.value
        : this.lastSuccessAt,
    lastError: lastError.present ? lastError.value : this.lastError,
    retryCount: retryCount ?? this.retryCount,
  );
  SyncQueueTableData copyWithCompanion(SyncQueueTableCompanion data) {
    return SyncQueueTableData(
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      domain: data.domain.present ? data.domain.value : this.domain,
      operation: data.operation.present ? data.operation.value : this.operation,
      status: data.status.present ? data.status.value : this.status,
      queuedAt: data.queuedAt.present ? data.queuedAt.value : this.queuedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      lastAttemptAt: data.lastAttemptAt.present
          ? data.lastAttemptAt.value
          : this.lastAttemptAt,
      lastSuccessAt: data.lastSuccessAt.present
          ? data.lastSuccessAt.value
          : this.lastSuccessAt,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
      retryCount: data.retryCount.present
          ? data.retryCount.value
          : this.retryCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueTableData(')
          ..write('accountId: $accountId, ')
          ..write('domain: $domain, ')
          ..write('operation: $operation, ')
          ..write('status: $status, ')
          ..write('queuedAt: $queuedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('lastSuccessAt: $lastSuccessAt, ')
          ..write('lastError: $lastError, ')
          ..write('retryCount: $retryCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    accountId,
    domain,
    operation,
    status,
    queuedAt,
    updatedAt,
    lastAttemptAt,
    lastSuccessAt,
    lastError,
    retryCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueTableData &&
          other.accountId == this.accountId &&
          other.domain == this.domain &&
          other.operation == this.operation &&
          other.status == this.status &&
          other.queuedAt == this.queuedAt &&
          other.updatedAt == this.updatedAt &&
          other.lastAttemptAt == this.lastAttemptAt &&
          other.lastSuccessAt == this.lastSuccessAt &&
          other.lastError == this.lastError &&
          other.retryCount == this.retryCount);
}

class SyncQueueTableCompanion extends UpdateCompanion<SyncQueueTableData> {
  final Value<String> accountId;
  final Value<SyncDomain> domain;
  final Value<SyncQueueOperation> operation;
  final Value<SyncQueueStatus> status;
  final Value<DateTime> queuedAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> lastAttemptAt;
  final Value<DateTime?> lastSuccessAt;
  final Value<String?> lastError;
  final Value<int> retryCount;
  final Value<int> rowid;
  const SyncQueueTableCompanion({
    this.accountId = const Value.absent(),
    this.domain = const Value.absent(),
    this.operation = const Value.absent(),
    this.status = const Value.absent(),
    this.queuedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
    this.lastSuccessAt = const Value.absent(),
    this.lastError = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncQueueTableCompanion.insert({
    required String accountId,
    required SyncDomain domain,
    required SyncQueueOperation operation,
    this.status = const Value.absent(),
    required DateTime queuedAt,
    required DateTime updatedAt,
    this.lastAttemptAt = const Value.absent(),
    this.lastSuccessAt = const Value.absent(),
    this.lastError = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : accountId = Value(accountId),
       domain = Value(domain),
       operation = Value(operation),
       queuedAt = Value(queuedAt),
       updatedAt = Value(updatedAt);
  static Insertable<SyncQueueTableData> custom({
    Expression<String>? accountId,
    Expression<String>? domain,
    Expression<String>? operation,
    Expression<String>? status,
    Expression<DateTime>? queuedAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? lastAttemptAt,
    Expression<DateTime>? lastSuccessAt,
    Expression<String>? lastError,
    Expression<int>? retryCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (accountId != null) 'account_id': accountId,
      if (domain != null) 'domain': domain,
      if (operation != null) 'operation': operation,
      if (status != null) 'status': status,
      if (queuedAt != null) 'queued_at': queuedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (lastAttemptAt != null) 'last_attempt_at': lastAttemptAt,
      if (lastSuccessAt != null) 'last_success_at': lastSuccessAt,
      if (lastError != null) 'last_error': lastError,
      if (retryCount != null) 'retry_count': retryCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncQueueTableCompanion copyWith({
    Value<String>? accountId,
    Value<SyncDomain>? domain,
    Value<SyncQueueOperation>? operation,
    Value<SyncQueueStatus>? status,
    Value<DateTime>? queuedAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? lastAttemptAt,
    Value<DateTime?>? lastSuccessAt,
    Value<String?>? lastError,
    Value<int>? retryCount,
    Value<int>? rowid,
  }) {
    return SyncQueueTableCompanion(
      accountId: accountId ?? this.accountId,
      domain: domain ?? this.domain,
      operation: operation ?? this.operation,
      status: status ?? this.status,
      queuedAt: queuedAt ?? this.queuedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastAttemptAt: lastAttemptAt ?? this.lastAttemptAt,
      lastSuccessAt: lastSuccessAt ?? this.lastSuccessAt,
      lastError: lastError ?? this.lastError,
      retryCount: retryCount ?? this.retryCount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (domain.present) {
      map['domain'] = Variable<String>(
        $SyncQueueTableTable.$converterdomain.toSql(domain.value),
      );
    }
    if (operation.present) {
      map['operation'] = Variable<String>(
        $SyncQueueTableTable.$converteroperation.toSql(operation.value),
      );
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $SyncQueueTableTable.$converterstatus.toSql(status.value),
      );
    }
    if (queuedAt.present) {
      map['queued_at'] = Variable<DateTime>(queuedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (lastAttemptAt.present) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt.value);
    }
    if (lastSuccessAt.present) {
      map['last_success_at'] = Variable<DateTime>(lastSuccessAt.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueTableCompanion(')
          ..write('accountId: $accountId, ')
          ..write('domain: $domain, ')
          ..write('operation: $operation, ')
          ..write('status: $status, ')
          ..write('queuedAt: $queuedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('lastSuccessAt: $lastSuccessAt, ')
          ..write('lastError: $lastError, ')
          ..write('retryCount: $retryCount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTableTable usersTable = $UsersTableTable(this);
  late final $GoalsTableTable goalsTable = $GoalsTableTable(this);
  late final $ExercisesTableTable exercisesTable = $ExercisesTableTable(this);
  late final $WorkoutTemplatesTableTable workoutTemplatesTable =
      $WorkoutTemplatesTableTable(this);
  late final $WorkoutTemplateItemsTableTable workoutTemplateItemsTable =
      $WorkoutTemplateItemsTableTable(this);
  late final $WorkoutSessionsTableTable workoutSessionsTable =
      $WorkoutSessionsTableTable(this);
  late final $WorkoutExerciseEntriesTableTable workoutExerciseEntriesTable =
      $WorkoutExerciseEntriesTableTable(this);
  late final $SetEntriesTableTable setEntriesTable = $SetEntriesTableTable(
    this,
  );
  late final $BodyLogsTableTable bodyLogsTable = $BodyLogsTableTable(this);
  late final $FoodsTableTable foodsTable = $FoodsTableTable(this);
  late final $FoodPortionsTableTable foodPortionsTable =
      $FoodPortionsTableTable(this);
  late final $MealEntriesTableTable mealEntriesTable = $MealEntriesTableTable(
    this,
  );
  late final $HydrationLogsTableTable hydrationLogsTable =
      $HydrationLogsTableTable(this);
  late final $SavedMealsTableTable savedMealsTable = $SavedMealsTableTable(
    this,
  );
  late final $SavedMealItemsTableTable savedMealItemsTable =
      $SavedMealItemsTableTable(this);
  late final $RemindersTableTable remindersTable = $RemindersTableTable(this);
  late final $HealthProfilesTableTable healthProfilesTable =
      $HealthProfilesTableTable(this);
  late final $HealthSyncRecordsTableTable healthSyncRecordsTable =
      $HealthSyncRecordsTableTable(this);
  late final $HealthStatusLogsTableTable healthStatusLogsTable =
      $HealthStatusLogsTableTable(this);
  late final $InsightsTableTable insightsTable = $InsightsTableTable(this);
  late final $AppSettingsTableTable appSettingsTable = $AppSettingsTableTable(
    this,
  );
  late final $SyncQueueTableTable syncQueueTable = $SyncQueueTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    usersTable,
    goalsTable,
    exercisesTable,
    workoutTemplatesTable,
    workoutTemplateItemsTable,
    workoutSessionsTable,
    workoutExerciseEntriesTable,
    setEntriesTable,
    bodyLogsTable,
    foodsTable,
    foodPortionsTable,
    mealEntriesTable,
    hydrationLogsTable,
    savedMealsTable,
    savedMealItemsTable,
    remindersTable,
    healthProfilesTable,
    healthSyncRecordsTable,
    healthStatusLogsTable,
    insightsTable,
    appSettingsTable,
    syncQueueTable,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'workout_templates_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('workout_template_items_table', kind: UpdateKind.delete),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'workout_templates_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('workout_sessions_table', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'workout_sessions_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('workout_exercise_entries_table', kind: UpdateKind.delete),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'workout_exercise_entries_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('set_entries_table', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'foods_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('food_portions_table', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'saved_meals_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('saved_meal_items_table', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$UsersTableTableCreateCompanionBuilder =
    UsersTableCompanion Function({
      required String id,
      required String displayName,
      required WeightUnit preferredWeightUnit,
      required BodyMetricUnit preferredBodyMetricUnit,
      Value<double?> originalHeightValue,
      Value<BodyMetricUnit?> originalHeightUnit,
      Value<double?> canonicalHeightCentimeters,
      Value<ActivityLevel?> activityLevel,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$UsersTableTableUpdateCompanionBuilder =
    UsersTableCompanion Function({
      Value<String> id,
      Value<String> displayName,
      Value<WeightUnit> preferredWeightUnit,
      Value<BodyMetricUnit> preferredBodyMetricUnit,
      Value<double?> originalHeightValue,
      Value<BodyMetricUnit?> originalHeightUnit,
      Value<double?> canonicalHeightCentimeters,
      Value<ActivityLevel?> activityLevel,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$UsersTableTableFilterComposer
    extends Composer<_$AppDatabase, $UsersTableTable> {
  $$UsersTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<WeightUnit, WeightUnit, String>
  get preferredWeightUnit => $composableBuilder(
    column: $table.preferredWeightUnit,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<BodyMetricUnit, BodyMetricUnit, String>
  get preferredBodyMetricUnit => $composableBuilder(
    column: $table.preferredBodyMetricUnit,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<double> get originalHeightValue => $composableBuilder(
    column: $table.originalHeightValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<BodyMetricUnit?, BodyMetricUnit, String>
  get originalHeightUnit => $composableBuilder(
    column: $table.originalHeightUnit,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<double> get canonicalHeightCentimeters => $composableBuilder(
    column: $table.canonicalHeightCentimeters,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ActivityLevel?, ActivityLevel, String>
  get activityLevel => $composableBuilder(
    column: $table.activityLevel,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UsersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTableTable> {
  $$UsersTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get preferredWeightUnit => $composableBuilder(
    column: $table.preferredWeightUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get preferredBodyMetricUnit => $composableBuilder(
    column: $table.preferredBodyMetricUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get originalHeightValue => $composableBuilder(
    column: $table.originalHeightValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originalHeightUnit => $composableBuilder(
    column: $table.originalHeightUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get canonicalHeightCentimeters => $composableBuilder(
    column: $table.canonicalHeightCentimeters,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get activityLevel => $composableBuilder(
    column: $table.activityLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTableTable> {
  $$UsersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<WeightUnit, String>
  get preferredWeightUnit => $composableBuilder(
    column: $table.preferredWeightUnit,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<BodyMetricUnit, String>
  get preferredBodyMetricUnit => $composableBuilder(
    column: $table.preferredBodyMetricUnit,
    builder: (column) => column,
  );

  GeneratedColumn<double> get originalHeightValue => $composableBuilder(
    column: $table.originalHeightValue,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<BodyMetricUnit?, String>
  get originalHeightUnit => $composableBuilder(
    column: $table.originalHeightUnit,
    builder: (column) => column,
  );

  GeneratedColumn<double> get canonicalHeightCentimeters => $composableBuilder(
    column: $table.canonicalHeightCentimeters,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<ActivityLevel?, String> get activityLevel =>
      $composableBuilder(
        column: $table.activityLevel,
        builder: (column) => column,
      );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UsersTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTableTable,
          UsersTableData,
          $$UsersTableTableFilterComposer,
          $$UsersTableTableOrderingComposer,
          $$UsersTableTableAnnotationComposer,
          $$UsersTableTableCreateCompanionBuilder,
          $$UsersTableTableUpdateCompanionBuilder,
          (
            UsersTableData,
            BaseReferences<_$AppDatabase, $UsersTableTable, UsersTableData>,
          ),
          UsersTableData,
          PrefetchHooks Function()
        > {
  $$UsersTableTableTableManager(_$AppDatabase db, $UsersTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<WeightUnit> preferredWeightUnit = const Value.absent(),
                Value<BodyMetricUnit> preferredBodyMetricUnit =
                    const Value.absent(),
                Value<double?> originalHeightValue = const Value.absent(),
                Value<BodyMetricUnit?> originalHeightUnit =
                    const Value.absent(),
                Value<double?> canonicalHeightCentimeters =
                    const Value.absent(),
                Value<ActivityLevel?> activityLevel = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersTableCompanion(
                id: id,
                displayName: displayName,
                preferredWeightUnit: preferredWeightUnit,
                preferredBodyMetricUnit: preferredBodyMetricUnit,
                originalHeightValue: originalHeightValue,
                originalHeightUnit: originalHeightUnit,
                canonicalHeightCentimeters: canonicalHeightCentimeters,
                activityLevel: activityLevel,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String displayName,
                required WeightUnit preferredWeightUnit,
                required BodyMetricUnit preferredBodyMetricUnit,
                Value<double?> originalHeightValue = const Value.absent(),
                Value<BodyMetricUnit?> originalHeightUnit =
                    const Value.absent(),
                Value<double?> canonicalHeightCentimeters =
                    const Value.absent(),
                Value<ActivityLevel?> activityLevel = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => UsersTableCompanion.insert(
                id: id,
                displayName: displayName,
                preferredWeightUnit: preferredWeightUnit,
                preferredBodyMetricUnit: preferredBodyMetricUnit,
                originalHeightValue: originalHeightValue,
                originalHeightUnit: originalHeightUnit,
                canonicalHeightCentimeters: canonicalHeightCentimeters,
                activityLevel: activityLevel,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UsersTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTableTable,
      UsersTableData,
      $$UsersTableTableFilterComposer,
      $$UsersTableTableOrderingComposer,
      $$UsersTableTableAnnotationComposer,
      $$UsersTableTableCreateCompanionBuilder,
      $$UsersTableTableUpdateCompanionBuilder,
      (
        UsersTableData,
        BaseReferences<_$AppDatabase, $UsersTableTable, UsersTableData>,
      ),
      UsersTableData,
      PrefetchHooks Function()
    >;
typedef $$GoalsTableTableCreateCompanionBuilder =
    GoalsTableCompanion Function({
      required String id,
      required GoalType type,
      Value<String?> title,
      Value<double?> originalTargetWeightValue,
      Value<WeightUnit?> originalTargetWeightUnit,
      Value<double?> canonicalTargetWeightKilograms,
      required int targetCalories,
      required double targetProteinGrams,
      required double targetCarbsGrams,
      required double targetFatGrams,
      Value<bool> isActive,
      required DateTime startedAt,
      Value<DateTime?> endedAt,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$GoalsTableTableUpdateCompanionBuilder =
    GoalsTableCompanion Function({
      Value<String> id,
      Value<GoalType> type,
      Value<String?> title,
      Value<double?> originalTargetWeightValue,
      Value<WeightUnit?> originalTargetWeightUnit,
      Value<double?> canonicalTargetWeightKilograms,
      Value<int> targetCalories,
      Value<double> targetProteinGrams,
      Value<double> targetCarbsGrams,
      Value<double> targetFatGrams,
      Value<bool> isActive,
      Value<DateTime> startedAt,
      Value<DateTime?> endedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$GoalsTableTableFilterComposer
    extends Composer<_$AppDatabase, $GoalsTableTable> {
  $$GoalsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<GoalType, GoalType, String> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get originalTargetWeightValue => $composableBuilder(
    column: $table.originalTargetWeightValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<WeightUnit?, WeightUnit, String>
  get originalTargetWeightUnit => $composableBuilder(
    column: $table.originalTargetWeightUnit,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<double> get canonicalTargetWeightKilograms =>
      $composableBuilder(
        column: $table.canonicalTargetWeightKilograms,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<int> get targetCalories => $composableBuilder(
    column: $table.targetCalories,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetProteinGrams => $composableBuilder(
    column: $table.targetProteinGrams,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetCarbsGrams => $composableBuilder(
    column: $table.targetCarbsGrams,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetFatGrams => $composableBuilder(
    column: $table.targetFatGrams,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GoalsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $GoalsTableTable> {
  $$GoalsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get originalTargetWeightValue => $composableBuilder(
    column: $table.originalTargetWeightValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originalTargetWeightUnit => $composableBuilder(
    column: $table.originalTargetWeightUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get canonicalTargetWeightKilograms =>
      $composableBuilder(
        column: $table.canonicalTargetWeightKilograms,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get targetCalories => $composableBuilder(
    column: $table.targetCalories,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetProteinGrams => $composableBuilder(
    column: $table.targetProteinGrams,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetCarbsGrams => $composableBuilder(
    column: $table.targetCarbsGrams,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetFatGrams => $composableBuilder(
    column: $table.targetFatGrams,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GoalsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $GoalsTableTable> {
  $$GoalsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<GoalType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<double> get originalTargetWeightValue => $composableBuilder(
    column: $table.originalTargetWeightValue,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<WeightUnit?, String>
  get originalTargetWeightUnit => $composableBuilder(
    column: $table.originalTargetWeightUnit,
    builder: (column) => column,
  );

  GeneratedColumn<double> get canonicalTargetWeightKilograms =>
      $composableBuilder(
        column: $table.canonicalTargetWeightKilograms,
        builder: (column) => column,
      );

  GeneratedColumn<int> get targetCalories => $composableBuilder(
    column: $table.targetCalories,
    builder: (column) => column,
  );

  GeneratedColumn<double> get targetProteinGrams => $composableBuilder(
    column: $table.targetProteinGrams,
    builder: (column) => column,
  );

  GeneratedColumn<double> get targetCarbsGrams => $composableBuilder(
    column: $table.targetCarbsGrams,
    builder: (column) => column,
  );

  GeneratedColumn<double> get targetFatGrams => $composableBuilder(
    column: $table.targetFatGrams,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$GoalsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GoalsTableTable,
          GoalsTableData,
          $$GoalsTableTableFilterComposer,
          $$GoalsTableTableOrderingComposer,
          $$GoalsTableTableAnnotationComposer,
          $$GoalsTableTableCreateCompanionBuilder,
          $$GoalsTableTableUpdateCompanionBuilder,
          (
            GoalsTableData,
            BaseReferences<_$AppDatabase, $GoalsTableTable, GoalsTableData>,
          ),
          GoalsTableData,
          PrefetchHooks Function()
        > {
  $$GoalsTableTableTableManager(_$AppDatabase db, $GoalsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoalsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoalsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoalsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<GoalType> type = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<double?> originalTargetWeightValue = const Value.absent(),
                Value<WeightUnit?> originalTargetWeightUnit =
                    const Value.absent(),
                Value<double?> canonicalTargetWeightKilograms =
                    const Value.absent(),
                Value<int> targetCalories = const Value.absent(),
                Value<double> targetProteinGrams = const Value.absent(),
                Value<double> targetCarbsGrams = const Value.absent(),
                Value<double> targetFatGrams = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GoalsTableCompanion(
                id: id,
                type: type,
                title: title,
                originalTargetWeightValue: originalTargetWeightValue,
                originalTargetWeightUnit: originalTargetWeightUnit,
                canonicalTargetWeightKilograms: canonicalTargetWeightKilograms,
                targetCalories: targetCalories,
                targetProteinGrams: targetProteinGrams,
                targetCarbsGrams: targetCarbsGrams,
                targetFatGrams: targetFatGrams,
                isActive: isActive,
                startedAt: startedAt,
                endedAt: endedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required GoalType type,
                Value<String?> title = const Value.absent(),
                Value<double?> originalTargetWeightValue = const Value.absent(),
                Value<WeightUnit?> originalTargetWeightUnit =
                    const Value.absent(),
                Value<double?> canonicalTargetWeightKilograms =
                    const Value.absent(),
                required int targetCalories,
                required double targetProteinGrams,
                required double targetCarbsGrams,
                required double targetFatGrams,
                Value<bool> isActive = const Value.absent(),
                required DateTime startedAt,
                Value<DateTime?> endedAt = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => GoalsTableCompanion.insert(
                id: id,
                type: type,
                title: title,
                originalTargetWeightValue: originalTargetWeightValue,
                originalTargetWeightUnit: originalTargetWeightUnit,
                canonicalTargetWeightKilograms: canonicalTargetWeightKilograms,
                targetCalories: targetCalories,
                targetProteinGrams: targetProteinGrams,
                targetCarbsGrams: targetCarbsGrams,
                targetFatGrams: targetFatGrams,
                isActive: isActive,
                startedAt: startedAt,
                endedAt: endedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GoalsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GoalsTableTable,
      GoalsTableData,
      $$GoalsTableTableFilterComposer,
      $$GoalsTableTableOrderingComposer,
      $$GoalsTableTableAnnotationComposer,
      $$GoalsTableTableCreateCompanionBuilder,
      $$GoalsTableTableUpdateCompanionBuilder,
      (
        GoalsTableData,
        BaseReferences<_$AppDatabase, $GoalsTableTable, GoalsTableData>,
      ),
      GoalsTableData,
      PrefetchHooks Function()
    >;
typedef $$ExercisesTableTableCreateCompanionBuilder =
    ExercisesTableCompanion Function({
      required String id,
      required String name,
      required String primaryMuscleGroup,
      Value<bool> isBuiltIn,
      Value<String?> notes,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ExercisesTableTableUpdateCompanionBuilder =
    ExercisesTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> primaryMuscleGroup,
      Value<bool> isBuiltIn,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$ExercisesTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ExercisesTableTable,
          ExercisesTableData
        > {
  $$ExercisesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $WorkoutTemplateItemsTableTable,
    List<WorkoutTemplateItemsTableData>
  >
  _workoutTemplateItemsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.workoutTemplateItemsTable,
        aliasName: $_aliasNameGenerator(
          db.exercisesTable.id,
          db.workoutTemplateItemsTable.exerciseId,
        ),
      );

  $$WorkoutTemplateItemsTableTableProcessedTableManager
  get workoutTemplateItemsTableRefs {
    final manager = $$WorkoutTemplateItemsTableTableTableManager(
      $_db,
      $_db.workoutTemplateItemsTable,
    ).filter((f) => f.exerciseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _workoutTemplateItemsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $WorkoutExerciseEntriesTableTable,
    List<WorkoutExerciseEntriesTableData>
  >
  _workoutExerciseEntriesTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.workoutExerciseEntriesTable,
        aliasName: $_aliasNameGenerator(
          db.exercisesTable.id,
          db.workoutExerciseEntriesTable.exerciseId,
        ),
      );

  $$WorkoutExerciseEntriesTableTableProcessedTableManager
  get workoutExerciseEntriesTableRefs {
    final manager = $$WorkoutExerciseEntriesTableTableTableManager(
      $_db,
      $_db.workoutExerciseEntriesTable,
    ).filter((f) => f.exerciseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _workoutExerciseEntriesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ExercisesTableTableFilterComposer
    extends Composer<_$AppDatabase, $ExercisesTableTable> {
  $$ExercisesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get primaryMuscleGroup => $composableBuilder(
    column: $table.primaryMuscleGroup,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> workoutTemplateItemsTableRefs(
    Expression<bool> Function($$WorkoutTemplateItemsTableTableFilterComposer f)
    f,
  ) {
    final $$WorkoutTemplateItemsTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.workoutTemplateItemsTable,
          getReferencedColumn: (t) => t.exerciseId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$WorkoutTemplateItemsTableTableFilterComposer(
                $db: $db,
                $table: $db.workoutTemplateItemsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> workoutExerciseEntriesTableRefs(
    Expression<bool> Function(
      $$WorkoutExerciseEntriesTableTableFilterComposer f,
    )
    f,
  ) {
    final $$WorkoutExerciseEntriesTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.workoutExerciseEntriesTable,
          getReferencedColumn: (t) => t.exerciseId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$WorkoutExerciseEntriesTableTableFilterComposer(
                $db: $db,
                $table: $db.workoutExerciseEntriesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ExercisesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ExercisesTableTable> {
  $$ExercisesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get primaryMuscleGroup => $composableBuilder(
    column: $table.primaryMuscleGroup,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExercisesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExercisesTableTable> {
  $$ExercisesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get primaryMuscleGroup => $composableBuilder(
    column: $table.primaryMuscleGroup,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isBuiltIn =>
      $composableBuilder(column: $table.isBuiltIn, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> workoutTemplateItemsTableRefs<T extends Object>(
    Expression<T> Function($$WorkoutTemplateItemsTableTableAnnotationComposer a)
    f,
  ) {
    final $$WorkoutTemplateItemsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.workoutTemplateItemsTable,
          getReferencedColumn: (t) => t.exerciseId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$WorkoutTemplateItemsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.workoutTemplateItemsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> workoutExerciseEntriesTableRefs<T extends Object>(
    Expression<T> Function(
      $$WorkoutExerciseEntriesTableTableAnnotationComposer a,
    )
    f,
  ) {
    final $$WorkoutExerciseEntriesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.workoutExerciseEntriesTable,
          getReferencedColumn: (t) => t.exerciseId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$WorkoutExerciseEntriesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.workoutExerciseEntriesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ExercisesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExercisesTableTable,
          ExercisesTableData,
          $$ExercisesTableTableFilterComposer,
          $$ExercisesTableTableOrderingComposer,
          $$ExercisesTableTableAnnotationComposer,
          $$ExercisesTableTableCreateCompanionBuilder,
          $$ExercisesTableTableUpdateCompanionBuilder,
          (ExercisesTableData, $$ExercisesTableTableReferences),
          ExercisesTableData,
          PrefetchHooks Function({
            bool workoutTemplateItemsTableRefs,
            bool workoutExerciseEntriesTableRefs,
          })
        > {
  $$ExercisesTableTableTableManager(
    _$AppDatabase db,
    $ExercisesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExercisesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExercisesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExercisesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> primaryMuscleGroup = const Value.absent(),
                Value<bool> isBuiltIn = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExercisesTableCompanion(
                id: id,
                name: name,
                primaryMuscleGroup: primaryMuscleGroup,
                isBuiltIn: isBuiltIn,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String primaryMuscleGroup,
                Value<bool> isBuiltIn = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ExercisesTableCompanion.insert(
                id: id,
                name: name,
                primaryMuscleGroup: primaryMuscleGroup,
                isBuiltIn: isBuiltIn,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExercisesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                workoutTemplateItemsTableRefs = false,
                workoutExerciseEntriesTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (workoutTemplateItemsTableRefs)
                      db.workoutTemplateItemsTable,
                    if (workoutExerciseEntriesTableRefs)
                      db.workoutExerciseEntriesTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (workoutTemplateItemsTableRefs)
                        await $_getPrefetchedData<
                          ExercisesTableData,
                          $ExercisesTableTable,
                          WorkoutTemplateItemsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$ExercisesTableTableReferences
                              ._workoutTemplateItemsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ExercisesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).workoutTemplateItemsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.exerciseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (workoutExerciseEntriesTableRefs)
                        await $_getPrefetchedData<
                          ExercisesTableData,
                          $ExercisesTableTable,
                          WorkoutExerciseEntriesTableData
                        >(
                          currentTable: table,
                          referencedTable: $$ExercisesTableTableReferences
                              ._workoutExerciseEntriesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ExercisesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).workoutExerciseEntriesTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.exerciseId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ExercisesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExercisesTableTable,
      ExercisesTableData,
      $$ExercisesTableTableFilterComposer,
      $$ExercisesTableTableOrderingComposer,
      $$ExercisesTableTableAnnotationComposer,
      $$ExercisesTableTableCreateCompanionBuilder,
      $$ExercisesTableTableUpdateCompanionBuilder,
      (ExercisesTableData, $$ExercisesTableTableReferences),
      ExercisesTableData,
      PrefetchHooks Function({
        bool workoutTemplateItemsTableRefs,
        bool workoutExerciseEntriesTableRefs,
      })
    >;
typedef $$WorkoutTemplatesTableTableCreateCompanionBuilder =
    WorkoutTemplatesTableCompanion Function({
      required String id,
      required String name,
      Value<String?> notes,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$WorkoutTemplatesTableTableUpdateCompanionBuilder =
    WorkoutTemplatesTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$WorkoutTemplatesTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $WorkoutTemplatesTableTable,
          WorkoutTemplatesTableData
        > {
  $$WorkoutTemplatesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $WorkoutTemplateItemsTableTable,
    List<WorkoutTemplateItemsTableData>
  >
  _workoutTemplateItemsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.workoutTemplateItemsTable,
        aliasName: $_aliasNameGenerator(
          db.workoutTemplatesTable.id,
          db.workoutTemplateItemsTable.templateId,
        ),
      );

  $$WorkoutTemplateItemsTableTableProcessedTableManager
  get workoutTemplateItemsTableRefs {
    final manager = $$WorkoutTemplateItemsTableTableTableManager(
      $_db,
      $_db.workoutTemplateItemsTable,
    ).filter((f) => f.templateId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _workoutTemplateItemsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $WorkoutSessionsTableTable,
    List<WorkoutSessionsTableData>
  >
  _workoutSessionsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.workoutSessionsTable,
        aliasName: $_aliasNameGenerator(
          db.workoutTemplatesTable.id,
          db.workoutSessionsTable.templateId,
        ),
      );

  $$WorkoutSessionsTableTableProcessedTableManager
  get workoutSessionsTableRefs {
    final manager = $$WorkoutSessionsTableTableTableManager(
      $_db,
      $_db.workoutSessionsTable,
    ).filter((f) => f.templateId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _workoutSessionsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WorkoutTemplatesTableTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutTemplatesTableTable> {
  $$WorkoutTemplatesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> workoutTemplateItemsTableRefs(
    Expression<bool> Function($$WorkoutTemplateItemsTableTableFilterComposer f)
    f,
  ) {
    final $$WorkoutTemplateItemsTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.workoutTemplateItemsTable,
          getReferencedColumn: (t) => t.templateId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$WorkoutTemplateItemsTableTableFilterComposer(
                $db: $db,
                $table: $db.workoutTemplateItemsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> workoutSessionsTableRefs(
    Expression<bool> Function($$WorkoutSessionsTableTableFilterComposer f) f,
  ) {
    final $$WorkoutSessionsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workoutSessionsTable,
      getReferencedColumn: (t) => t.templateId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutSessionsTableTableFilterComposer(
            $db: $db,
            $table: $db.workoutSessionsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WorkoutTemplatesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutTemplatesTableTable> {
  $$WorkoutTemplatesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WorkoutTemplatesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutTemplatesTableTable> {
  $$WorkoutTemplatesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> workoutTemplateItemsTableRefs<T extends Object>(
    Expression<T> Function($$WorkoutTemplateItemsTableTableAnnotationComposer a)
    f,
  ) {
    final $$WorkoutTemplateItemsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.workoutTemplateItemsTable,
          getReferencedColumn: (t) => t.templateId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$WorkoutTemplateItemsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.workoutTemplateItemsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> workoutSessionsTableRefs<T extends Object>(
    Expression<T> Function($$WorkoutSessionsTableTableAnnotationComposer a) f,
  ) {
    final $$WorkoutSessionsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.workoutSessionsTable,
          getReferencedColumn: (t) => t.templateId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$WorkoutSessionsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.workoutSessionsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$WorkoutTemplatesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkoutTemplatesTableTable,
          WorkoutTemplatesTableData,
          $$WorkoutTemplatesTableTableFilterComposer,
          $$WorkoutTemplatesTableTableOrderingComposer,
          $$WorkoutTemplatesTableTableAnnotationComposer,
          $$WorkoutTemplatesTableTableCreateCompanionBuilder,
          $$WorkoutTemplatesTableTableUpdateCompanionBuilder,
          (WorkoutTemplatesTableData, $$WorkoutTemplatesTableTableReferences),
          WorkoutTemplatesTableData,
          PrefetchHooks Function({
            bool workoutTemplateItemsTableRefs,
            bool workoutSessionsTableRefs,
          })
        > {
  $$WorkoutTemplatesTableTableTableManager(
    _$AppDatabase db,
    $WorkoutTemplatesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutTemplatesTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$WorkoutTemplatesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$WorkoutTemplatesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutTemplatesTableCompanion(
                id: id,
                name: name,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => WorkoutTemplatesTableCompanion.insert(
                id: id,
                name: name,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WorkoutTemplatesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                workoutTemplateItemsTableRefs = false,
                workoutSessionsTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (workoutTemplateItemsTableRefs)
                      db.workoutTemplateItemsTable,
                    if (workoutSessionsTableRefs) db.workoutSessionsTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (workoutTemplateItemsTableRefs)
                        await $_getPrefetchedData<
                          WorkoutTemplatesTableData,
                          $WorkoutTemplatesTableTable,
                          WorkoutTemplateItemsTableData
                        >(
                          currentTable: table,
                          referencedTable:
                              $$WorkoutTemplatesTableTableReferences
                                  ._workoutTemplateItemsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WorkoutTemplatesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).workoutTemplateItemsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.templateId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (workoutSessionsTableRefs)
                        await $_getPrefetchedData<
                          WorkoutTemplatesTableData,
                          $WorkoutTemplatesTableTable,
                          WorkoutSessionsTableData
                        >(
                          currentTable: table,
                          referencedTable:
                              $$WorkoutTemplatesTableTableReferences
                                  ._workoutSessionsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WorkoutTemplatesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).workoutSessionsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.templateId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$WorkoutTemplatesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkoutTemplatesTableTable,
      WorkoutTemplatesTableData,
      $$WorkoutTemplatesTableTableFilterComposer,
      $$WorkoutTemplatesTableTableOrderingComposer,
      $$WorkoutTemplatesTableTableAnnotationComposer,
      $$WorkoutTemplatesTableTableCreateCompanionBuilder,
      $$WorkoutTemplatesTableTableUpdateCompanionBuilder,
      (WorkoutTemplatesTableData, $$WorkoutTemplatesTableTableReferences),
      WorkoutTemplatesTableData,
      PrefetchHooks Function({
        bool workoutTemplateItemsTableRefs,
        bool workoutSessionsTableRefs,
      })
    >;
typedef $$WorkoutTemplateItemsTableTableCreateCompanionBuilder =
    WorkoutTemplateItemsTableCompanion Function({
      required String id,
      required String templateId,
      required String exerciseId,
      required int orderIndex,
      required int targetSets,
      required String targetReps,
      Value<String?> notes,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$WorkoutTemplateItemsTableTableUpdateCompanionBuilder =
    WorkoutTemplateItemsTableCompanion Function({
      Value<String> id,
      Value<String> templateId,
      Value<String> exerciseId,
      Value<int> orderIndex,
      Value<int> targetSets,
      Value<String> targetReps,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$WorkoutTemplateItemsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $WorkoutTemplateItemsTableTable,
          WorkoutTemplateItemsTableData
        > {
  $$WorkoutTemplateItemsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $WorkoutTemplatesTableTable _templateIdTable(_$AppDatabase db) =>
      db.workoutTemplatesTable.createAlias(
        $_aliasNameGenerator(
          db.workoutTemplateItemsTable.templateId,
          db.workoutTemplatesTable.id,
        ),
      );

  $$WorkoutTemplatesTableTableProcessedTableManager get templateId {
    final $_column = $_itemColumn<String>('template_id')!;

    final manager = $$WorkoutTemplatesTableTableTableManager(
      $_db,
      $_db.workoutTemplatesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_templateIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ExercisesTableTable _exerciseIdTable(_$AppDatabase db) =>
      db.exercisesTable.createAlias(
        $_aliasNameGenerator(
          db.workoutTemplateItemsTable.exerciseId,
          db.exercisesTable.id,
        ),
      );

  $$ExercisesTableTableProcessedTableManager get exerciseId {
    final $_column = $_itemColumn<String>('exercise_id')!;

    final manager = $$ExercisesTableTableTableManager(
      $_db,
      $_db.exercisesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WorkoutTemplateItemsTableTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutTemplateItemsTableTable> {
  $$WorkoutTemplateItemsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetSets => $composableBuilder(
    column: $table.targetSets,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetReps => $composableBuilder(
    column: $table.targetReps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$WorkoutTemplatesTableTableFilterComposer get templateId {
    final $$WorkoutTemplatesTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.templateId,
          referencedTable: $db.workoutTemplatesTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$WorkoutTemplatesTableTableFilterComposer(
                $db: $db,
                $table: $db.workoutTemplatesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$ExercisesTableTableFilterComposer get exerciseId {
    final $$ExercisesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercisesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableTableFilterComposer(
            $db: $db,
            $table: $db.exercisesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkoutTemplateItemsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutTemplateItemsTableTable> {
  $$WorkoutTemplateItemsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetSets => $composableBuilder(
    column: $table.targetSets,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetReps => $composableBuilder(
    column: $table.targetReps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$WorkoutTemplatesTableTableOrderingComposer get templateId {
    final $$WorkoutTemplatesTableTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.templateId,
          referencedTable: $db.workoutTemplatesTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$WorkoutTemplatesTableTableOrderingComposer(
                $db: $db,
                $table: $db.workoutTemplatesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$ExercisesTableTableOrderingComposer get exerciseId {
    final $$ExercisesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercisesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableTableOrderingComposer(
            $db: $db,
            $table: $db.exercisesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkoutTemplateItemsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutTemplateItemsTableTable> {
  $$WorkoutTemplateItemsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => column,
  );

  GeneratedColumn<int> get targetSets => $composableBuilder(
    column: $table.targetSets,
    builder: (column) => column,
  );

  GeneratedColumn<String> get targetReps => $composableBuilder(
    column: $table.targetReps,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$WorkoutTemplatesTableTableAnnotationComposer get templateId {
    final $$WorkoutTemplatesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.templateId,
          referencedTable: $db.workoutTemplatesTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$WorkoutTemplatesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.workoutTemplatesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$ExercisesTableTableAnnotationComposer get exerciseId {
    final $$ExercisesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercisesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.exercisesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkoutTemplateItemsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkoutTemplateItemsTableTable,
          WorkoutTemplateItemsTableData,
          $$WorkoutTemplateItemsTableTableFilterComposer,
          $$WorkoutTemplateItemsTableTableOrderingComposer,
          $$WorkoutTemplateItemsTableTableAnnotationComposer,
          $$WorkoutTemplateItemsTableTableCreateCompanionBuilder,
          $$WorkoutTemplateItemsTableTableUpdateCompanionBuilder,
          (
            WorkoutTemplateItemsTableData,
            $$WorkoutTemplateItemsTableTableReferences,
          ),
          WorkoutTemplateItemsTableData,
          PrefetchHooks Function({bool templateId, bool exerciseId})
        > {
  $$WorkoutTemplateItemsTableTableTableManager(
    _$AppDatabase db,
    $WorkoutTemplateItemsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutTemplateItemsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$WorkoutTemplateItemsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$WorkoutTemplateItemsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> templateId = const Value.absent(),
                Value<String> exerciseId = const Value.absent(),
                Value<int> orderIndex = const Value.absent(),
                Value<int> targetSets = const Value.absent(),
                Value<String> targetReps = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutTemplateItemsTableCompanion(
                id: id,
                templateId: templateId,
                exerciseId: exerciseId,
                orderIndex: orderIndex,
                targetSets: targetSets,
                targetReps: targetReps,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String templateId,
                required String exerciseId,
                required int orderIndex,
                required int targetSets,
                required String targetReps,
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => WorkoutTemplateItemsTableCompanion.insert(
                id: id,
                templateId: templateId,
                exerciseId: exerciseId,
                orderIndex: orderIndex,
                targetSets: targetSets,
                targetReps: targetReps,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WorkoutTemplateItemsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({templateId = false, exerciseId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (templateId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.templateId,
                                referencedTable:
                                    $$WorkoutTemplateItemsTableTableReferences
                                        ._templateIdTable(db),
                                referencedColumn:
                                    $$WorkoutTemplateItemsTableTableReferences
                                        ._templateIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (exerciseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.exerciseId,
                                referencedTable:
                                    $$WorkoutTemplateItemsTableTableReferences
                                        ._exerciseIdTable(db),
                                referencedColumn:
                                    $$WorkoutTemplateItemsTableTableReferences
                                        ._exerciseIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WorkoutTemplateItemsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkoutTemplateItemsTableTable,
      WorkoutTemplateItemsTableData,
      $$WorkoutTemplateItemsTableTableFilterComposer,
      $$WorkoutTemplateItemsTableTableOrderingComposer,
      $$WorkoutTemplateItemsTableTableAnnotationComposer,
      $$WorkoutTemplateItemsTableTableCreateCompanionBuilder,
      $$WorkoutTemplateItemsTableTableUpdateCompanionBuilder,
      (
        WorkoutTemplateItemsTableData,
        $$WorkoutTemplateItemsTableTableReferences,
      ),
      WorkoutTemplateItemsTableData,
      PrefetchHooks Function({bool templateId, bool exerciseId})
    >;
typedef $$WorkoutSessionsTableTableCreateCompanionBuilder =
    WorkoutSessionsTableCompanion Function({
      required String id,
      Value<String?> templateId,
      Value<String?> notes,
      required DateTime startedAt,
      Value<DateTime?> endedAt,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$WorkoutSessionsTableTableUpdateCompanionBuilder =
    WorkoutSessionsTableCompanion Function({
      Value<String> id,
      Value<String?> templateId,
      Value<String?> notes,
      Value<DateTime> startedAt,
      Value<DateTime?> endedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$WorkoutSessionsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $WorkoutSessionsTableTable,
          WorkoutSessionsTableData
        > {
  $$WorkoutSessionsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $WorkoutTemplatesTableTable _templateIdTable(_$AppDatabase db) =>
      db.workoutTemplatesTable.createAlias(
        $_aliasNameGenerator(
          db.workoutSessionsTable.templateId,
          db.workoutTemplatesTable.id,
        ),
      );

  $$WorkoutTemplatesTableTableProcessedTableManager? get templateId {
    final $_column = $_itemColumn<String>('template_id');
    if ($_column == null) return null;
    final manager = $$WorkoutTemplatesTableTableTableManager(
      $_db,
      $_db.workoutTemplatesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_templateIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $WorkoutExerciseEntriesTableTable,
    List<WorkoutExerciseEntriesTableData>
  >
  _workoutExerciseEntriesTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.workoutExerciseEntriesTable,
        aliasName: $_aliasNameGenerator(
          db.workoutSessionsTable.id,
          db.workoutExerciseEntriesTable.sessionId,
        ),
      );

  $$WorkoutExerciseEntriesTableTableProcessedTableManager
  get workoutExerciseEntriesTableRefs {
    final manager = $$WorkoutExerciseEntriesTableTableTableManager(
      $_db,
      $_db.workoutExerciseEntriesTable,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _workoutExerciseEntriesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WorkoutSessionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTableTable> {
  $$WorkoutSessionsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$WorkoutTemplatesTableTableFilterComposer get templateId {
    final $$WorkoutTemplatesTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.templateId,
          referencedTable: $db.workoutTemplatesTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$WorkoutTemplatesTableTableFilterComposer(
                $db: $db,
                $table: $db.workoutTemplatesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<bool> workoutExerciseEntriesTableRefs(
    Expression<bool> Function(
      $$WorkoutExerciseEntriesTableTableFilterComposer f,
    )
    f,
  ) {
    final $$WorkoutExerciseEntriesTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.workoutExerciseEntriesTable,
          getReferencedColumn: (t) => t.sessionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$WorkoutExerciseEntriesTableTableFilterComposer(
                $db: $db,
                $table: $db.workoutExerciseEntriesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$WorkoutSessionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTableTable> {
  $$WorkoutSessionsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$WorkoutTemplatesTableTableOrderingComposer get templateId {
    final $$WorkoutTemplatesTableTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.templateId,
          referencedTable: $db.workoutTemplatesTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$WorkoutTemplatesTableTableOrderingComposer(
                $db: $db,
                $table: $db.workoutTemplatesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$WorkoutSessionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTableTable> {
  $$WorkoutSessionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$WorkoutTemplatesTableTableAnnotationComposer get templateId {
    final $$WorkoutTemplatesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.templateId,
          referencedTable: $db.workoutTemplatesTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$WorkoutTemplatesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.workoutTemplatesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<T> workoutExerciseEntriesTableRefs<T extends Object>(
    Expression<T> Function(
      $$WorkoutExerciseEntriesTableTableAnnotationComposer a,
    )
    f,
  ) {
    final $$WorkoutExerciseEntriesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.workoutExerciseEntriesTable,
          getReferencedColumn: (t) => t.sessionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$WorkoutExerciseEntriesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.workoutExerciseEntriesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$WorkoutSessionsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkoutSessionsTableTable,
          WorkoutSessionsTableData,
          $$WorkoutSessionsTableTableFilterComposer,
          $$WorkoutSessionsTableTableOrderingComposer,
          $$WorkoutSessionsTableTableAnnotationComposer,
          $$WorkoutSessionsTableTableCreateCompanionBuilder,
          $$WorkoutSessionsTableTableUpdateCompanionBuilder,
          (WorkoutSessionsTableData, $$WorkoutSessionsTableTableReferences),
          WorkoutSessionsTableData,
          PrefetchHooks Function({
            bool templateId,
            bool workoutExerciseEntriesTableRefs,
          })
        > {
  $$WorkoutSessionsTableTableTableManager(
    _$AppDatabase db,
    $WorkoutSessionsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutSessionsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutSessionsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$WorkoutSessionsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> templateId = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutSessionsTableCompanion(
                id: id,
                templateId: templateId,
                notes: notes,
                startedAt: startedAt,
                endedAt: endedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> templateId = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime startedAt,
                Value<DateTime?> endedAt = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => WorkoutSessionsTableCompanion.insert(
                id: id,
                templateId: templateId,
                notes: notes,
                startedAt: startedAt,
                endedAt: endedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WorkoutSessionsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({templateId = false, workoutExerciseEntriesTableRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (workoutExerciseEntriesTableRefs)
                      db.workoutExerciseEntriesTable,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (templateId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.templateId,
                                    referencedTable:
                                        $$WorkoutSessionsTableTableReferences
                                            ._templateIdTable(db),
                                    referencedColumn:
                                        $$WorkoutSessionsTableTableReferences
                                            ._templateIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (workoutExerciseEntriesTableRefs)
                        await $_getPrefetchedData<
                          WorkoutSessionsTableData,
                          $WorkoutSessionsTableTable,
                          WorkoutExerciseEntriesTableData
                        >(
                          currentTable: table,
                          referencedTable: $$WorkoutSessionsTableTableReferences
                              ._workoutExerciseEntriesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WorkoutSessionsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).workoutExerciseEntriesTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sessionId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$WorkoutSessionsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkoutSessionsTableTable,
      WorkoutSessionsTableData,
      $$WorkoutSessionsTableTableFilterComposer,
      $$WorkoutSessionsTableTableOrderingComposer,
      $$WorkoutSessionsTableTableAnnotationComposer,
      $$WorkoutSessionsTableTableCreateCompanionBuilder,
      $$WorkoutSessionsTableTableUpdateCompanionBuilder,
      (WorkoutSessionsTableData, $$WorkoutSessionsTableTableReferences),
      WorkoutSessionsTableData,
      PrefetchHooks Function({
        bool templateId,
        bool workoutExerciseEntriesTableRefs,
      })
    >;
typedef $$WorkoutExerciseEntriesTableTableCreateCompanionBuilder =
    WorkoutExerciseEntriesTableCompanion Function({
      required String id,
      required String sessionId,
      required String exerciseId,
      required int orderIndex,
      Value<String?> notes,
      Value<String?> supersetGroupId,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$WorkoutExerciseEntriesTableTableUpdateCompanionBuilder =
    WorkoutExerciseEntriesTableCompanion Function({
      Value<String> id,
      Value<String> sessionId,
      Value<String> exerciseId,
      Value<int> orderIndex,
      Value<String?> notes,
      Value<String?> supersetGroupId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$WorkoutExerciseEntriesTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $WorkoutExerciseEntriesTableTable,
          WorkoutExerciseEntriesTableData
        > {
  $$WorkoutExerciseEntriesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $WorkoutSessionsTableTable _sessionIdTable(_$AppDatabase db) =>
      db.workoutSessionsTable.createAlias(
        $_aliasNameGenerator(
          db.workoutExerciseEntriesTable.sessionId,
          db.workoutSessionsTable.id,
        ),
      );

  $$WorkoutSessionsTableTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<String>('session_id')!;

    final manager = $$WorkoutSessionsTableTableTableManager(
      $_db,
      $_db.workoutSessionsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ExercisesTableTable _exerciseIdTable(_$AppDatabase db) =>
      db.exercisesTable.createAlias(
        $_aliasNameGenerator(
          db.workoutExerciseEntriesTable.exerciseId,
          db.exercisesTable.id,
        ),
      );

  $$ExercisesTableTableProcessedTableManager get exerciseId {
    final $_column = $_itemColumn<String>('exercise_id')!;

    final manager = $$ExercisesTableTableTableManager(
      $_db,
      $_db.exercisesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$SetEntriesTableTable, List<SetEntriesTableData>>
  _setEntriesTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.setEntriesTable,
    aliasName: $_aliasNameGenerator(
      db.workoutExerciseEntriesTable.id,
      db.setEntriesTable.exerciseEntryId,
    ),
  );

  $$SetEntriesTableTableProcessedTableManager get setEntriesTableRefs {
    final manager =
        $$SetEntriesTableTableTableManager($_db, $_db.setEntriesTable).filter(
          (f) => f.exerciseEntryId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _setEntriesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WorkoutExerciseEntriesTableTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutExerciseEntriesTableTable> {
  $$WorkoutExerciseEntriesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supersetGroupId => $composableBuilder(
    column: $table.supersetGroupId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$WorkoutSessionsTableTableFilterComposer get sessionId {
    final $$WorkoutSessionsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.workoutSessionsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutSessionsTableTableFilterComposer(
            $db: $db,
            $table: $db.workoutSessionsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExercisesTableTableFilterComposer get exerciseId {
    final $$ExercisesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercisesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableTableFilterComposer(
            $db: $db,
            $table: $db.exercisesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> setEntriesTableRefs(
    Expression<bool> Function($$SetEntriesTableTableFilterComposer f) f,
  ) {
    final $$SetEntriesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.setEntriesTable,
      getReferencedColumn: (t) => t.exerciseEntryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SetEntriesTableTableFilterComposer(
            $db: $db,
            $table: $db.setEntriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WorkoutExerciseEntriesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutExerciseEntriesTableTable> {
  $$WorkoutExerciseEntriesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supersetGroupId => $composableBuilder(
    column: $table.supersetGroupId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$WorkoutSessionsTableTableOrderingComposer get sessionId {
    final $$WorkoutSessionsTableTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.sessionId,
          referencedTable: $db.workoutSessionsTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$WorkoutSessionsTableTableOrderingComposer(
                $db: $db,
                $table: $db.workoutSessionsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$ExercisesTableTableOrderingComposer get exerciseId {
    final $$ExercisesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercisesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableTableOrderingComposer(
            $db: $db,
            $table: $db.exercisesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkoutExerciseEntriesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutExerciseEntriesTableTable> {
  $$WorkoutExerciseEntriesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get supersetGroupId => $composableBuilder(
    column: $table.supersetGroupId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$WorkoutSessionsTableTableAnnotationComposer get sessionId {
    final $$WorkoutSessionsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.sessionId,
          referencedTable: $db.workoutSessionsTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$WorkoutSessionsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.workoutSessionsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$ExercisesTableTableAnnotationComposer get exerciseId {
    final $$ExercisesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercisesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.exercisesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> setEntriesTableRefs<T extends Object>(
    Expression<T> Function($$SetEntriesTableTableAnnotationComposer a) f,
  ) {
    final $$SetEntriesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.setEntriesTable,
      getReferencedColumn: (t) => t.exerciseEntryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SetEntriesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.setEntriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WorkoutExerciseEntriesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkoutExerciseEntriesTableTable,
          WorkoutExerciseEntriesTableData,
          $$WorkoutExerciseEntriesTableTableFilterComposer,
          $$WorkoutExerciseEntriesTableTableOrderingComposer,
          $$WorkoutExerciseEntriesTableTableAnnotationComposer,
          $$WorkoutExerciseEntriesTableTableCreateCompanionBuilder,
          $$WorkoutExerciseEntriesTableTableUpdateCompanionBuilder,
          (
            WorkoutExerciseEntriesTableData,
            $$WorkoutExerciseEntriesTableTableReferences,
          ),
          WorkoutExerciseEntriesTableData,
          PrefetchHooks Function({
            bool sessionId,
            bool exerciseId,
            bool setEntriesTableRefs,
          })
        > {
  $$WorkoutExerciseEntriesTableTableTableManager(
    _$AppDatabase db,
    $WorkoutExerciseEntriesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutExerciseEntriesTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$WorkoutExerciseEntriesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$WorkoutExerciseEntriesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<String> exerciseId = const Value.absent(),
                Value<int> orderIndex = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> supersetGroupId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutExerciseEntriesTableCompanion(
                id: id,
                sessionId: sessionId,
                exerciseId: exerciseId,
                orderIndex: orderIndex,
                notes: notes,
                supersetGroupId: supersetGroupId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sessionId,
                required String exerciseId,
                required int orderIndex,
                Value<String?> notes = const Value.absent(),
                Value<String?> supersetGroupId = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => WorkoutExerciseEntriesTableCompanion.insert(
                id: id,
                sessionId: sessionId,
                exerciseId: exerciseId,
                orderIndex: orderIndex,
                notes: notes,
                supersetGroupId: supersetGroupId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WorkoutExerciseEntriesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                sessionId = false,
                exerciseId = false,
                setEntriesTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (setEntriesTableRefs) db.setEntriesTable,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (sessionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.sessionId,
                                    referencedTable:
                                        $$WorkoutExerciseEntriesTableTableReferences
                                            ._sessionIdTable(db),
                                    referencedColumn:
                                        $$WorkoutExerciseEntriesTableTableReferences
                                            ._sessionIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (exerciseId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.exerciseId,
                                    referencedTable:
                                        $$WorkoutExerciseEntriesTableTableReferences
                                            ._exerciseIdTable(db),
                                    referencedColumn:
                                        $$WorkoutExerciseEntriesTableTableReferences
                                            ._exerciseIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (setEntriesTableRefs)
                        await $_getPrefetchedData<
                          WorkoutExerciseEntriesTableData,
                          $WorkoutExerciseEntriesTableTable,
                          SetEntriesTableData
                        >(
                          currentTable: table,
                          referencedTable:
                              $$WorkoutExerciseEntriesTableTableReferences
                                  ._setEntriesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WorkoutExerciseEntriesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).setEntriesTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.exerciseEntryId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$WorkoutExerciseEntriesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkoutExerciseEntriesTableTable,
      WorkoutExerciseEntriesTableData,
      $$WorkoutExerciseEntriesTableTableFilterComposer,
      $$WorkoutExerciseEntriesTableTableOrderingComposer,
      $$WorkoutExerciseEntriesTableTableAnnotationComposer,
      $$WorkoutExerciseEntriesTableTableCreateCompanionBuilder,
      $$WorkoutExerciseEntriesTableTableUpdateCompanionBuilder,
      (
        WorkoutExerciseEntriesTableData,
        $$WorkoutExerciseEntriesTableTableReferences,
      ),
      WorkoutExerciseEntriesTableData,
      PrefetchHooks Function({
        bool sessionId,
        bool exerciseId,
        bool setEntriesTableRefs,
      })
    >;
typedef $$SetEntriesTableTableCreateCompanionBuilder =
    SetEntriesTableCompanion Function({
      required String id,
      required String exerciseEntryId,
      required SetType setType,
      required int orderIndex,
      required int reps,
      Value<double?> originalWeightValue,
      Value<WeightUnit?> originalWeightUnit,
      Value<double?> canonicalWeightKilograms,
      Value<double?> rpe,
      Value<String?> tempo,
      Value<int?> restSeconds,
      Value<String?> notes,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$SetEntriesTableTableUpdateCompanionBuilder =
    SetEntriesTableCompanion Function({
      Value<String> id,
      Value<String> exerciseEntryId,
      Value<SetType> setType,
      Value<int> orderIndex,
      Value<int> reps,
      Value<double?> originalWeightValue,
      Value<WeightUnit?> originalWeightUnit,
      Value<double?> canonicalWeightKilograms,
      Value<double?> rpe,
      Value<String?> tempo,
      Value<int?> restSeconds,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$SetEntriesTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SetEntriesTableTable,
          SetEntriesTableData
        > {
  $$SetEntriesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $WorkoutExerciseEntriesTableTable _exerciseEntryIdTable(
    _$AppDatabase db,
  ) => db.workoutExerciseEntriesTable.createAlias(
    $_aliasNameGenerator(
      db.setEntriesTable.exerciseEntryId,
      db.workoutExerciseEntriesTable.id,
    ),
  );

  $$WorkoutExerciseEntriesTableTableProcessedTableManager get exerciseEntryId {
    final $_column = $_itemColumn<String>('exercise_entry_id')!;

    final manager = $$WorkoutExerciseEntriesTableTableTableManager(
      $_db,
      $_db.workoutExerciseEntriesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseEntryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SetEntriesTableTableFilterComposer
    extends Composer<_$AppDatabase, $SetEntriesTableTable> {
  $$SetEntriesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SetType, SetType, String> get setType =>
      $composableBuilder(
        column: $table.setType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get originalWeightValue => $composableBuilder(
    column: $table.originalWeightValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<WeightUnit?, WeightUnit, String>
  get originalWeightUnit => $composableBuilder(
    column: $table.originalWeightUnit,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<double> get canonicalWeightKilograms => $composableBuilder(
    column: $table.canonicalWeightKilograms,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rpe => $composableBuilder(
    column: $table.rpe,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tempo => $composableBuilder(
    column: $table.tempo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get restSeconds => $composableBuilder(
    column: $table.restSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$WorkoutExerciseEntriesTableTableFilterComposer get exerciseEntryId {
    final $$WorkoutExerciseEntriesTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.exerciseEntryId,
          referencedTable: $db.workoutExerciseEntriesTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$WorkoutExerciseEntriesTableTableFilterComposer(
                $db: $db,
                $table: $db.workoutExerciseEntriesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$SetEntriesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SetEntriesTableTable> {
  $$SetEntriesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get setType => $composableBuilder(
    column: $table.setType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get originalWeightValue => $composableBuilder(
    column: $table.originalWeightValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originalWeightUnit => $composableBuilder(
    column: $table.originalWeightUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get canonicalWeightKilograms => $composableBuilder(
    column: $table.canonicalWeightKilograms,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rpe => $composableBuilder(
    column: $table.rpe,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tempo => $composableBuilder(
    column: $table.tempo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get restSeconds => $composableBuilder(
    column: $table.restSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$WorkoutExerciseEntriesTableTableOrderingComposer get exerciseEntryId {
    final $$WorkoutExerciseEntriesTableTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.exerciseEntryId,
          referencedTable: $db.workoutExerciseEntriesTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$WorkoutExerciseEntriesTableTableOrderingComposer(
                $db: $db,
                $table: $db.workoutExerciseEntriesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$SetEntriesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SetEntriesTableTable> {
  $$SetEntriesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SetType, String> get setType =>
      $composableBuilder(column: $table.setType, builder: (column) => column);

  GeneratedColumn<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<double> get originalWeightValue => $composableBuilder(
    column: $table.originalWeightValue,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<WeightUnit?, String>
  get originalWeightUnit => $composableBuilder(
    column: $table.originalWeightUnit,
    builder: (column) => column,
  );

  GeneratedColumn<double> get canonicalWeightKilograms => $composableBuilder(
    column: $table.canonicalWeightKilograms,
    builder: (column) => column,
  );

  GeneratedColumn<double> get rpe =>
      $composableBuilder(column: $table.rpe, builder: (column) => column);

  GeneratedColumn<String> get tempo =>
      $composableBuilder(column: $table.tempo, builder: (column) => column);

  GeneratedColumn<int> get restSeconds => $composableBuilder(
    column: $table.restSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$WorkoutExerciseEntriesTableTableAnnotationComposer get exerciseEntryId {
    final $$WorkoutExerciseEntriesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.exerciseEntryId,
          referencedTable: $db.workoutExerciseEntriesTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$WorkoutExerciseEntriesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.workoutExerciseEntriesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$SetEntriesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SetEntriesTableTable,
          SetEntriesTableData,
          $$SetEntriesTableTableFilterComposer,
          $$SetEntriesTableTableOrderingComposer,
          $$SetEntriesTableTableAnnotationComposer,
          $$SetEntriesTableTableCreateCompanionBuilder,
          $$SetEntriesTableTableUpdateCompanionBuilder,
          (SetEntriesTableData, $$SetEntriesTableTableReferences),
          SetEntriesTableData,
          PrefetchHooks Function({bool exerciseEntryId})
        > {
  $$SetEntriesTableTableTableManager(
    _$AppDatabase db,
    $SetEntriesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SetEntriesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SetEntriesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SetEntriesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> exerciseEntryId = const Value.absent(),
                Value<SetType> setType = const Value.absent(),
                Value<int> orderIndex = const Value.absent(),
                Value<int> reps = const Value.absent(),
                Value<double?> originalWeightValue = const Value.absent(),
                Value<WeightUnit?> originalWeightUnit = const Value.absent(),
                Value<double?> canonicalWeightKilograms = const Value.absent(),
                Value<double?> rpe = const Value.absent(),
                Value<String?> tempo = const Value.absent(),
                Value<int?> restSeconds = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SetEntriesTableCompanion(
                id: id,
                exerciseEntryId: exerciseEntryId,
                setType: setType,
                orderIndex: orderIndex,
                reps: reps,
                originalWeightValue: originalWeightValue,
                originalWeightUnit: originalWeightUnit,
                canonicalWeightKilograms: canonicalWeightKilograms,
                rpe: rpe,
                tempo: tempo,
                restSeconds: restSeconds,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String exerciseEntryId,
                required SetType setType,
                required int orderIndex,
                required int reps,
                Value<double?> originalWeightValue = const Value.absent(),
                Value<WeightUnit?> originalWeightUnit = const Value.absent(),
                Value<double?> canonicalWeightKilograms = const Value.absent(),
                Value<double?> rpe = const Value.absent(),
                Value<String?> tempo = const Value.absent(),
                Value<int?> restSeconds = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => SetEntriesTableCompanion.insert(
                id: id,
                exerciseEntryId: exerciseEntryId,
                setType: setType,
                orderIndex: orderIndex,
                reps: reps,
                originalWeightValue: originalWeightValue,
                originalWeightUnit: originalWeightUnit,
                canonicalWeightKilograms: canonicalWeightKilograms,
                rpe: rpe,
                tempo: tempo,
                restSeconds: restSeconds,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SetEntriesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({exerciseEntryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (exerciseEntryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.exerciseEntryId,
                                referencedTable:
                                    $$SetEntriesTableTableReferences
                                        ._exerciseEntryIdTable(db),
                                referencedColumn:
                                    $$SetEntriesTableTableReferences
                                        ._exerciseEntryIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SetEntriesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SetEntriesTableTable,
      SetEntriesTableData,
      $$SetEntriesTableTableFilterComposer,
      $$SetEntriesTableTableOrderingComposer,
      $$SetEntriesTableTableAnnotationComposer,
      $$SetEntriesTableTableCreateCompanionBuilder,
      $$SetEntriesTableTableUpdateCompanionBuilder,
      (SetEntriesTableData, $$SetEntriesTableTableReferences),
      SetEntriesTableData,
      PrefetchHooks Function({bool exerciseEntryId})
    >;
typedef $$BodyLogsTableTableCreateCompanionBuilder =
    BodyLogsTableCompanion Function({
      required String id,
      required DateTime loggedAt,
      Value<double?> originalWeightValue,
      Value<WeightUnit?> originalWeightUnit,
      Value<double?> canonicalWeightKilograms,
      Value<double?> bodyFatPercentage,
      Value<double?> originalWaistValue,
      Value<BodyMetricUnit?> originalWaistUnit,
      Value<double?> canonicalWaistCentimeters,
      Value<String?> notes,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$BodyLogsTableTableUpdateCompanionBuilder =
    BodyLogsTableCompanion Function({
      Value<String> id,
      Value<DateTime> loggedAt,
      Value<double?> originalWeightValue,
      Value<WeightUnit?> originalWeightUnit,
      Value<double?> canonicalWeightKilograms,
      Value<double?> bodyFatPercentage,
      Value<double?> originalWaistValue,
      Value<BodyMetricUnit?> originalWaistUnit,
      Value<double?> canonicalWaistCentimeters,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$BodyLogsTableTableFilterComposer
    extends Composer<_$AppDatabase, $BodyLogsTableTable> {
  $$BodyLogsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get originalWeightValue => $composableBuilder(
    column: $table.originalWeightValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<WeightUnit?, WeightUnit, String>
  get originalWeightUnit => $composableBuilder(
    column: $table.originalWeightUnit,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<double> get canonicalWeightKilograms => $composableBuilder(
    column: $table.canonicalWeightKilograms,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bodyFatPercentage => $composableBuilder(
    column: $table.bodyFatPercentage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get originalWaistValue => $composableBuilder(
    column: $table.originalWaistValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<BodyMetricUnit?, BodyMetricUnit, String>
  get originalWaistUnit => $composableBuilder(
    column: $table.originalWaistUnit,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<double> get canonicalWaistCentimeters => $composableBuilder(
    column: $table.canonicalWaistCentimeters,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BodyLogsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BodyLogsTableTable> {
  $$BodyLogsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get originalWeightValue => $composableBuilder(
    column: $table.originalWeightValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originalWeightUnit => $composableBuilder(
    column: $table.originalWeightUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get canonicalWeightKilograms => $composableBuilder(
    column: $table.canonicalWeightKilograms,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bodyFatPercentage => $composableBuilder(
    column: $table.bodyFatPercentage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get originalWaistValue => $composableBuilder(
    column: $table.originalWaistValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originalWaistUnit => $composableBuilder(
    column: $table.originalWaistUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get canonicalWaistCentimeters => $composableBuilder(
    column: $table.canonicalWaistCentimeters,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BodyLogsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BodyLogsTableTable> {
  $$BodyLogsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get loggedAt =>
      $composableBuilder(column: $table.loggedAt, builder: (column) => column);

  GeneratedColumn<double> get originalWeightValue => $composableBuilder(
    column: $table.originalWeightValue,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<WeightUnit?, String>
  get originalWeightUnit => $composableBuilder(
    column: $table.originalWeightUnit,
    builder: (column) => column,
  );

  GeneratedColumn<double> get canonicalWeightKilograms => $composableBuilder(
    column: $table.canonicalWeightKilograms,
    builder: (column) => column,
  );

  GeneratedColumn<double> get bodyFatPercentage => $composableBuilder(
    column: $table.bodyFatPercentage,
    builder: (column) => column,
  );

  GeneratedColumn<double> get originalWaistValue => $composableBuilder(
    column: $table.originalWaistValue,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<BodyMetricUnit?, String>
  get originalWaistUnit => $composableBuilder(
    column: $table.originalWaistUnit,
    builder: (column) => column,
  );

  GeneratedColumn<double> get canonicalWaistCentimeters => $composableBuilder(
    column: $table.canonicalWaistCentimeters,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$BodyLogsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BodyLogsTableTable,
          BodyLogsTableData,
          $$BodyLogsTableTableFilterComposer,
          $$BodyLogsTableTableOrderingComposer,
          $$BodyLogsTableTableAnnotationComposer,
          $$BodyLogsTableTableCreateCompanionBuilder,
          $$BodyLogsTableTableUpdateCompanionBuilder,
          (
            BodyLogsTableData,
            BaseReferences<
              _$AppDatabase,
              $BodyLogsTableTable,
              BodyLogsTableData
            >,
          ),
          BodyLogsTableData,
          PrefetchHooks Function()
        > {
  $$BodyLogsTableTableTableManager(_$AppDatabase db, $BodyLogsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BodyLogsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BodyLogsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BodyLogsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> loggedAt = const Value.absent(),
                Value<double?> originalWeightValue = const Value.absent(),
                Value<WeightUnit?> originalWeightUnit = const Value.absent(),
                Value<double?> canonicalWeightKilograms = const Value.absent(),
                Value<double?> bodyFatPercentage = const Value.absent(),
                Value<double?> originalWaistValue = const Value.absent(),
                Value<BodyMetricUnit?> originalWaistUnit = const Value.absent(),
                Value<double?> canonicalWaistCentimeters = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BodyLogsTableCompanion(
                id: id,
                loggedAt: loggedAt,
                originalWeightValue: originalWeightValue,
                originalWeightUnit: originalWeightUnit,
                canonicalWeightKilograms: canonicalWeightKilograms,
                bodyFatPercentage: bodyFatPercentage,
                originalWaistValue: originalWaistValue,
                originalWaistUnit: originalWaistUnit,
                canonicalWaistCentimeters: canonicalWaistCentimeters,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime loggedAt,
                Value<double?> originalWeightValue = const Value.absent(),
                Value<WeightUnit?> originalWeightUnit = const Value.absent(),
                Value<double?> canonicalWeightKilograms = const Value.absent(),
                Value<double?> bodyFatPercentage = const Value.absent(),
                Value<double?> originalWaistValue = const Value.absent(),
                Value<BodyMetricUnit?> originalWaistUnit = const Value.absent(),
                Value<double?> canonicalWaistCentimeters = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => BodyLogsTableCompanion.insert(
                id: id,
                loggedAt: loggedAt,
                originalWeightValue: originalWeightValue,
                originalWeightUnit: originalWeightUnit,
                canonicalWeightKilograms: canonicalWeightKilograms,
                bodyFatPercentage: bodyFatPercentage,
                originalWaistValue: originalWaistValue,
                originalWaistUnit: originalWaistUnit,
                canonicalWaistCentimeters: canonicalWaistCentimeters,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BodyLogsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BodyLogsTableTable,
      BodyLogsTableData,
      $$BodyLogsTableTableFilterComposer,
      $$BodyLogsTableTableOrderingComposer,
      $$BodyLogsTableTableAnnotationComposer,
      $$BodyLogsTableTableCreateCompanionBuilder,
      $$BodyLogsTableTableUpdateCompanionBuilder,
      (
        BodyLogsTableData,
        BaseReferences<_$AppDatabase, $BodyLogsTableTable, BodyLogsTableData>,
      ),
      BodyLogsTableData,
      PrefetchHooks Function()
    >;
typedef $$FoodsTableTableCreateCompanionBuilder =
    FoodsTableCompanion Function({
      required String id,
      required String name,
      Value<String?> brandName,
      Value<String?> barcode,
      required int caloriesPer100g,
      required double proteinPer100g,
      required double carbsPer100g,
      required double fatPer100g,
      required SyncSource source,
      Value<bool> isUserEdited,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$FoodsTableTableUpdateCompanionBuilder =
    FoodsTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> brandName,
      Value<String?> barcode,
      Value<int> caloriesPer100g,
      Value<double> proteinPer100g,
      Value<double> carbsPer100g,
      Value<double> fatPer100g,
      Value<SyncSource> source,
      Value<bool> isUserEdited,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$FoodsTableTableReferences
    extends BaseReferences<_$AppDatabase, $FoodsTableTable, FoodsTableData> {
  $$FoodsTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $FoodPortionsTableTable,
    List<FoodPortionsTableData>
  >
  _foodPortionsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.foodPortionsTable,
        aliasName: $_aliasNameGenerator(
          db.foodsTable.id,
          db.foodPortionsTable.foodId,
        ),
      );

  $$FoodPortionsTableTableProcessedTableManager get foodPortionsTableRefs {
    final manager = $$FoodPortionsTableTableTableManager(
      $_db,
      $_db.foodPortionsTable,
    ).filter((f) => f.foodId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _foodPortionsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MealEntriesTableTable, List<MealEntriesTableData>>
  _mealEntriesTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.mealEntriesTable,
    aliasName: $_aliasNameGenerator(
      db.foodsTable.id,
      db.mealEntriesTable.foodId,
    ),
  );

  $$MealEntriesTableTableProcessedTableManager get mealEntriesTableRefs {
    final manager = $$MealEntriesTableTableTableManager(
      $_db,
      $_db.mealEntriesTable,
    ).filter((f) => f.foodId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _mealEntriesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $SavedMealItemsTableTable,
    List<SavedMealItemsTableData>
  >
  _savedMealItemsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.savedMealItemsTable,
        aliasName: $_aliasNameGenerator(
          db.foodsTable.id,
          db.savedMealItemsTable.foodId,
        ),
      );

  $$SavedMealItemsTableTableProcessedTableManager get savedMealItemsTableRefs {
    final manager = $$SavedMealItemsTableTableTableManager(
      $_db,
      $_db.savedMealItemsTable,
    ).filter((f) => f.foodId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _savedMealItemsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FoodsTableTableFilterComposer
    extends Composer<_$AppDatabase, $FoodsTableTable> {
  $$FoodsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brandName => $composableBuilder(
    column: $table.brandName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get caloriesPer100g => $composableBuilder(
    column: $table.caloriesPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get proteinPer100g => $composableBuilder(
    column: $table.proteinPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbsPer100g => $composableBuilder(
    column: $table.carbsPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fatPer100g => $composableBuilder(
    column: $table.fatPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SyncSource, SyncSource, String> get source =>
      $composableBuilder(
        column: $table.source,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<bool> get isUserEdited => $composableBuilder(
    column: $table.isUserEdited,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> foodPortionsTableRefs(
    Expression<bool> Function($$FoodPortionsTableTableFilterComposer f) f,
  ) {
    final $$FoodPortionsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.foodPortionsTable,
      getReferencedColumn: (t) => t.foodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodPortionsTableTableFilterComposer(
            $db: $db,
            $table: $db.foodPortionsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> mealEntriesTableRefs(
    Expression<bool> Function($$MealEntriesTableTableFilterComposer f) f,
  ) {
    final $$MealEntriesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mealEntriesTable,
      getReferencedColumn: (t) => t.foodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealEntriesTableTableFilterComposer(
            $db: $db,
            $table: $db.mealEntriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> savedMealItemsTableRefs(
    Expression<bool> Function($$SavedMealItemsTableTableFilterComposer f) f,
  ) {
    final $$SavedMealItemsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.savedMealItemsTable,
      getReferencedColumn: (t) => t.foodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SavedMealItemsTableTableFilterComposer(
            $db: $db,
            $table: $db.savedMealItemsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FoodsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $FoodsTableTable> {
  $$FoodsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brandName => $composableBuilder(
    column: $table.brandName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get caloriesPer100g => $composableBuilder(
    column: $table.caloriesPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get proteinPer100g => $composableBuilder(
    column: $table.proteinPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbsPer100g => $composableBuilder(
    column: $table.carbsPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fatPer100g => $composableBuilder(
    column: $table.fatPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isUserEdited => $composableBuilder(
    column: $table.isUserEdited,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FoodsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoodsTableTable> {
  $$FoodsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get brandName =>
      $composableBuilder(column: $table.brandName, builder: (column) => column);

  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<int> get caloriesPer100g => $composableBuilder(
    column: $table.caloriesPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get proteinPer100g => $composableBuilder(
    column: $table.proteinPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get carbsPer100g => $composableBuilder(
    column: $table.carbsPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fatPer100g => $composableBuilder(
    column: $table.fatPer100g,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<SyncSource, String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<bool> get isUserEdited => $composableBuilder(
    column: $table.isUserEdited,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> foodPortionsTableRefs<T extends Object>(
    Expression<T> Function($$FoodPortionsTableTableAnnotationComposer a) f,
  ) {
    final $$FoodPortionsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.foodPortionsTable,
          getReferencedColumn: (t) => t.foodId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FoodPortionsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.foodPortionsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> mealEntriesTableRefs<T extends Object>(
    Expression<T> Function($$MealEntriesTableTableAnnotationComposer a) f,
  ) {
    final $$MealEntriesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mealEntriesTable,
      getReferencedColumn: (t) => t.foodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealEntriesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.mealEntriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> savedMealItemsTableRefs<T extends Object>(
    Expression<T> Function($$SavedMealItemsTableTableAnnotationComposer a) f,
  ) {
    final $$SavedMealItemsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.savedMealItemsTable,
          getReferencedColumn: (t) => t.foodId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SavedMealItemsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.savedMealItemsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$FoodsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FoodsTableTable,
          FoodsTableData,
          $$FoodsTableTableFilterComposer,
          $$FoodsTableTableOrderingComposer,
          $$FoodsTableTableAnnotationComposer,
          $$FoodsTableTableCreateCompanionBuilder,
          $$FoodsTableTableUpdateCompanionBuilder,
          (FoodsTableData, $$FoodsTableTableReferences),
          FoodsTableData,
          PrefetchHooks Function({
            bool foodPortionsTableRefs,
            bool mealEntriesTableRefs,
            bool savedMealItemsTableRefs,
          })
        > {
  $$FoodsTableTableTableManager(_$AppDatabase db, $FoodsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoodsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoodsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoodsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> brandName = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                Value<int> caloriesPer100g = const Value.absent(),
                Value<double> proteinPer100g = const Value.absent(),
                Value<double> carbsPer100g = const Value.absent(),
                Value<double> fatPer100g = const Value.absent(),
                Value<SyncSource> source = const Value.absent(),
                Value<bool> isUserEdited = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FoodsTableCompanion(
                id: id,
                name: name,
                brandName: brandName,
                barcode: barcode,
                caloriesPer100g: caloriesPer100g,
                proteinPer100g: proteinPer100g,
                carbsPer100g: carbsPer100g,
                fatPer100g: fatPer100g,
                source: source,
                isUserEdited: isUserEdited,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> brandName = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                required int caloriesPer100g,
                required double proteinPer100g,
                required double carbsPer100g,
                required double fatPer100g,
                required SyncSource source,
                Value<bool> isUserEdited = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => FoodsTableCompanion.insert(
                id: id,
                name: name,
                brandName: brandName,
                barcode: barcode,
                caloriesPer100g: caloriesPer100g,
                proteinPer100g: proteinPer100g,
                carbsPer100g: carbsPer100g,
                fatPer100g: fatPer100g,
                source: source,
                isUserEdited: isUserEdited,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FoodsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                foodPortionsTableRefs = false,
                mealEntriesTableRefs = false,
                savedMealItemsTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (foodPortionsTableRefs) db.foodPortionsTable,
                    if (mealEntriesTableRefs) db.mealEntriesTable,
                    if (savedMealItemsTableRefs) db.savedMealItemsTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (foodPortionsTableRefs)
                        await $_getPrefetchedData<
                          FoodsTableData,
                          $FoodsTableTable,
                          FoodPortionsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$FoodsTableTableReferences
                              ._foodPortionsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FoodsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).foodPortionsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.foodId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (mealEntriesTableRefs)
                        await $_getPrefetchedData<
                          FoodsTableData,
                          $FoodsTableTable,
                          MealEntriesTableData
                        >(
                          currentTable: table,
                          referencedTable: $$FoodsTableTableReferences
                              ._mealEntriesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FoodsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).mealEntriesTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.foodId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (savedMealItemsTableRefs)
                        await $_getPrefetchedData<
                          FoodsTableData,
                          $FoodsTableTable,
                          SavedMealItemsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$FoodsTableTableReferences
                              ._savedMealItemsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FoodsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).savedMealItemsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.foodId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$FoodsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FoodsTableTable,
      FoodsTableData,
      $$FoodsTableTableFilterComposer,
      $$FoodsTableTableOrderingComposer,
      $$FoodsTableTableAnnotationComposer,
      $$FoodsTableTableCreateCompanionBuilder,
      $$FoodsTableTableUpdateCompanionBuilder,
      (FoodsTableData, $$FoodsTableTableReferences),
      FoodsTableData,
      PrefetchHooks Function({
        bool foodPortionsTableRefs,
        bool mealEntriesTableRefs,
        bool savedMealItemsTableRefs,
      })
    >;
typedef $$FoodPortionsTableTableCreateCompanionBuilder =
    FoodPortionsTableCompanion Function({
      required String id,
      required String foodId,
      required FoodQuantityUnit unit,
      required String label,
      required double referenceAmount,
      Value<double?> canonicalGrams,
      Value<double?> canonicalMilliliters,
      required int sortOrder,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$FoodPortionsTableTableUpdateCompanionBuilder =
    FoodPortionsTableCompanion Function({
      Value<String> id,
      Value<String> foodId,
      Value<FoodQuantityUnit> unit,
      Value<String> label,
      Value<double> referenceAmount,
      Value<double?> canonicalGrams,
      Value<double?> canonicalMilliliters,
      Value<int> sortOrder,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$FoodPortionsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $FoodPortionsTableTable,
          FoodPortionsTableData
        > {
  $$FoodPortionsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $FoodsTableTable _foodIdTable(_$AppDatabase db) =>
      db.foodsTable.createAlias(
        $_aliasNameGenerator(db.foodPortionsTable.foodId, db.foodsTable.id),
      );

  $$FoodsTableTableProcessedTableManager get foodId {
    final $_column = $_itemColumn<String>('food_id')!;

    final manager = $$FoodsTableTableTableManager(
      $_db,
      $_db.foodsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_foodIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FoodPortionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $FoodPortionsTableTable> {
  $$FoodPortionsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<FoodQuantityUnit, FoodQuantityUnit, String>
  get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get referenceAmount => $composableBuilder(
    column: $table.referenceAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get canonicalGrams => $composableBuilder(
    column: $table.canonicalGrams,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get canonicalMilliliters => $composableBuilder(
    column: $table.canonicalMilliliters,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$FoodsTableTableFilterComposer get foodId {
    final $$FoodsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodId,
      referencedTable: $db.foodsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodsTableTableFilterComposer(
            $db: $db,
            $table: $db.foodsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FoodPortionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $FoodPortionsTableTable> {
  $$FoodPortionsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get referenceAmount => $composableBuilder(
    column: $table.referenceAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get canonicalGrams => $composableBuilder(
    column: $table.canonicalGrams,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get canonicalMilliliters => $composableBuilder(
    column: $table.canonicalMilliliters,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$FoodsTableTableOrderingComposer get foodId {
    final $$FoodsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodId,
      referencedTable: $db.foodsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodsTableTableOrderingComposer(
            $db: $db,
            $table: $db.foodsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FoodPortionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoodPortionsTableTable> {
  $$FoodPortionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<FoodQuantityUnit, String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<double> get referenceAmount => $composableBuilder(
    column: $table.referenceAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get canonicalGrams => $composableBuilder(
    column: $table.canonicalGrams,
    builder: (column) => column,
  );

  GeneratedColumn<double> get canonicalMilliliters => $composableBuilder(
    column: $table.canonicalMilliliters,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$FoodsTableTableAnnotationComposer get foodId {
    final $$FoodsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodId,
      referencedTable: $db.foodsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.foodsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FoodPortionsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FoodPortionsTableTable,
          FoodPortionsTableData,
          $$FoodPortionsTableTableFilterComposer,
          $$FoodPortionsTableTableOrderingComposer,
          $$FoodPortionsTableTableAnnotationComposer,
          $$FoodPortionsTableTableCreateCompanionBuilder,
          $$FoodPortionsTableTableUpdateCompanionBuilder,
          (FoodPortionsTableData, $$FoodPortionsTableTableReferences),
          FoodPortionsTableData,
          PrefetchHooks Function({bool foodId})
        > {
  $$FoodPortionsTableTableTableManager(
    _$AppDatabase db,
    $FoodPortionsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoodPortionsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoodPortionsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoodPortionsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> foodId = const Value.absent(),
                Value<FoodQuantityUnit> unit = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<double> referenceAmount = const Value.absent(),
                Value<double?> canonicalGrams = const Value.absent(),
                Value<double?> canonicalMilliliters = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FoodPortionsTableCompanion(
                id: id,
                foodId: foodId,
                unit: unit,
                label: label,
                referenceAmount: referenceAmount,
                canonicalGrams: canonicalGrams,
                canonicalMilliliters: canonicalMilliliters,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String foodId,
                required FoodQuantityUnit unit,
                required String label,
                required double referenceAmount,
                Value<double?> canonicalGrams = const Value.absent(),
                Value<double?> canonicalMilliliters = const Value.absent(),
                required int sortOrder,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => FoodPortionsTableCompanion.insert(
                id: id,
                foodId: foodId,
                unit: unit,
                label: label,
                referenceAmount: referenceAmount,
                canonicalGrams: canonicalGrams,
                canonicalMilliliters: canonicalMilliliters,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FoodPortionsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({foodId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (foodId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.foodId,
                                referencedTable:
                                    $$FoodPortionsTableTableReferences
                                        ._foodIdTable(db),
                                referencedColumn:
                                    $$FoodPortionsTableTableReferences
                                        ._foodIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FoodPortionsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FoodPortionsTableTable,
      FoodPortionsTableData,
      $$FoodPortionsTableTableFilterComposer,
      $$FoodPortionsTableTableOrderingComposer,
      $$FoodPortionsTableTableAnnotationComposer,
      $$FoodPortionsTableTableCreateCompanionBuilder,
      $$FoodPortionsTableTableUpdateCompanionBuilder,
      (FoodPortionsTableData, $$FoodPortionsTableTableReferences),
      FoodPortionsTableData,
      PrefetchHooks Function({bool foodId})
    >;
typedef $$MealEntriesTableTableCreateCompanionBuilder =
    MealEntriesTableCompanion Function({
      required String id,
      required String foodId,
      required MealType mealType,
      required double originalQuantityValue,
      required FoodQuantityUnit originalQuantityUnit,
      Value<double?> canonicalQuantityGrams,
      Value<double?> canonicalQuantityMilliliters,
      required DateTime loggedAt,
      Value<String?> notes,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$MealEntriesTableTableUpdateCompanionBuilder =
    MealEntriesTableCompanion Function({
      Value<String> id,
      Value<String> foodId,
      Value<MealType> mealType,
      Value<double> originalQuantityValue,
      Value<FoodQuantityUnit> originalQuantityUnit,
      Value<double?> canonicalQuantityGrams,
      Value<double?> canonicalQuantityMilliliters,
      Value<DateTime> loggedAt,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$MealEntriesTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MealEntriesTableTable,
          MealEntriesTableData
        > {
  $$MealEntriesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $FoodsTableTable _foodIdTable(_$AppDatabase db) =>
      db.foodsTable.createAlias(
        $_aliasNameGenerator(db.mealEntriesTable.foodId, db.foodsTable.id),
      );

  $$FoodsTableTableProcessedTableManager get foodId {
    final $_column = $_itemColumn<String>('food_id')!;

    final manager = $$FoodsTableTableTableManager(
      $_db,
      $_db.foodsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_foodIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MealEntriesTableTableFilterComposer
    extends Composer<_$AppDatabase, $MealEntriesTableTable> {
  $$MealEntriesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<MealType, MealType, String> get mealType =>
      $composableBuilder(
        column: $table.mealType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<double> get originalQuantityValue => $composableBuilder(
    column: $table.originalQuantityValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<FoodQuantityUnit, FoodQuantityUnit, String>
  get originalQuantityUnit => $composableBuilder(
    column: $table.originalQuantityUnit,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<double> get canonicalQuantityGrams => $composableBuilder(
    column: $table.canonicalQuantityGrams,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get canonicalQuantityMilliliters => $composableBuilder(
    column: $table.canonicalQuantityMilliliters,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$FoodsTableTableFilterComposer get foodId {
    final $$FoodsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodId,
      referencedTable: $db.foodsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodsTableTableFilterComposer(
            $db: $db,
            $table: $db.foodsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MealEntriesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $MealEntriesTableTable> {
  $$MealEntriesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mealType => $composableBuilder(
    column: $table.mealType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get originalQuantityValue => $composableBuilder(
    column: $table.originalQuantityValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originalQuantityUnit => $composableBuilder(
    column: $table.originalQuantityUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get canonicalQuantityGrams => $composableBuilder(
    column: $table.canonicalQuantityGrams,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get canonicalQuantityMilliliters =>
      $composableBuilder(
        column: $table.canonicalQuantityMilliliters,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$FoodsTableTableOrderingComposer get foodId {
    final $$FoodsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodId,
      referencedTable: $db.foodsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodsTableTableOrderingComposer(
            $db: $db,
            $table: $db.foodsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MealEntriesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $MealEntriesTableTable> {
  $$MealEntriesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MealType, String> get mealType =>
      $composableBuilder(column: $table.mealType, builder: (column) => column);

  GeneratedColumn<double> get originalQuantityValue => $composableBuilder(
    column: $table.originalQuantityValue,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<FoodQuantityUnit, String>
  get originalQuantityUnit => $composableBuilder(
    column: $table.originalQuantityUnit,
    builder: (column) => column,
  );

  GeneratedColumn<double> get canonicalQuantityGrams => $composableBuilder(
    column: $table.canonicalQuantityGrams,
    builder: (column) => column,
  );

  GeneratedColumn<double> get canonicalQuantityMilliliters =>
      $composableBuilder(
        column: $table.canonicalQuantityMilliliters,
        builder: (column) => column,
      );

  GeneratedColumn<DateTime> get loggedAt =>
      $composableBuilder(column: $table.loggedAt, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$FoodsTableTableAnnotationComposer get foodId {
    final $$FoodsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodId,
      referencedTable: $db.foodsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.foodsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MealEntriesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MealEntriesTableTable,
          MealEntriesTableData,
          $$MealEntriesTableTableFilterComposer,
          $$MealEntriesTableTableOrderingComposer,
          $$MealEntriesTableTableAnnotationComposer,
          $$MealEntriesTableTableCreateCompanionBuilder,
          $$MealEntriesTableTableUpdateCompanionBuilder,
          (MealEntriesTableData, $$MealEntriesTableTableReferences),
          MealEntriesTableData,
          PrefetchHooks Function({bool foodId})
        > {
  $$MealEntriesTableTableTableManager(
    _$AppDatabase db,
    $MealEntriesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MealEntriesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MealEntriesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MealEntriesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> foodId = const Value.absent(),
                Value<MealType> mealType = const Value.absent(),
                Value<double> originalQuantityValue = const Value.absent(),
                Value<FoodQuantityUnit> originalQuantityUnit =
                    const Value.absent(),
                Value<double?> canonicalQuantityGrams = const Value.absent(),
                Value<double?> canonicalQuantityMilliliters =
                    const Value.absent(),
                Value<DateTime> loggedAt = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MealEntriesTableCompanion(
                id: id,
                foodId: foodId,
                mealType: mealType,
                originalQuantityValue: originalQuantityValue,
                originalQuantityUnit: originalQuantityUnit,
                canonicalQuantityGrams: canonicalQuantityGrams,
                canonicalQuantityMilliliters: canonicalQuantityMilliliters,
                loggedAt: loggedAt,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String foodId,
                required MealType mealType,
                required double originalQuantityValue,
                required FoodQuantityUnit originalQuantityUnit,
                Value<double?> canonicalQuantityGrams = const Value.absent(),
                Value<double?> canonicalQuantityMilliliters =
                    const Value.absent(),
                required DateTime loggedAt,
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => MealEntriesTableCompanion.insert(
                id: id,
                foodId: foodId,
                mealType: mealType,
                originalQuantityValue: originalQuantityValue,
                originalQuantityUnit: originalQuantityUnit,
                canonicalQuantityGrams: canonicalQuantityGrams,
                canonicalQuantityMilliliters: canonicalQuantityMilliliters,
                loggedAt: loggedAt,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MealEntriesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({foodId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (foodId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.foodId,
                                referencedTable:
                                    $$MealEntriesTableTableReferences
                                        ._foodIdTable(db),
                                referencedColumn:
                                    $$MealEntriesTableTableReferences
                                        ._foodIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MealEntriesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MealEntriesTableTable,
      MealEntriesTableData,
      $$MealEntriesTableTableFilterComposer,
      $$MealEntriesTableTableOrderingComposer,
      $$MealEntriesTableTableAnnotationComposer,
      $$MealEntriesTableTableCreateCompanionBuilder,
      $$MealEntriesTableTableUpdateCompanionBuilder,
      (MealEntriesTableData, $$MealEntriesTableTableReferences),
      MealEntriesTableData,
      PrefetchHooks Function({bool foodId})
    >;
typedef $$HydrationLogsTableTableCreateCompanionBuilder =
    HydrationLogsTableCompanion Function({
      required String id,
      required double originalAmountValue,
      required VolumeUnit originalAmountUnit,
      required double canonicalMilliliters,
      required DateTime loggedAt,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$HydrationLogsTableTableUpdateCompanionBuilder =
    HydrationLogsTableCompanion Function({
      Value<String> id,
      Value<double> originalAmountValue,
      Value<VolumeUnit> originalAmountUnit,
      Value<double> canonicalMilliliters,
      Value<DateTime> loggedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$HydrationLogsTableTableFilterComposer
    extends Composer<_$AppDatabase, $HydrationLogsTableTable> {
  $$HydrationLogsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get originalAmountValue => $composableBuilder(
    column: $table.originalAmountValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<VolumeUnit, VolumeUnit, String>
  get originalAmountUnit => $composableBuilder(
    column: $table.originalAmountUnit,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<double> get canonicalMilliliters => $composableBuilder(
    column: $table.canonicalMilliliters,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HydrationLogsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $HydrationLogsTableTable> {
  $$HydrationLogsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get originalAmountValue => $composableBuilder(
    column: $table.originalAmountValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originalAmountUnit => $composableBuilder(
    column: $table.originalAmountUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get canonicalMilliliters => $composableBuilder(
    column: $table.canonicalMilliliters,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HydrationLogsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $HydrationLogsTableTable> {
  $$HydrationLogsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get originalAmountValue => $composableBuilder(
    column: $table.originalAmountValue,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<VolumeUnit, String> get originalAmountUnit =>
      $composableBuilder(
        column: $table.originalAmountUnit,
        builder: (column) => column,
      );

  GeneratedColumn<double> get canonicalMilliliters => $composableBuilder(
    column: $table.canonicalMilliliters,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get loggedAt =>
      $composableBuilder(column: $table.loggedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$HydrationLogsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HydrationLogsTableTable,
          HydrationLogsTableData,
          $$HydrationLogsTableTableFilterComposer,
          $$HydrationLogsTableTableOrderingComposer,
          $$HydrationLogsTableTableAnnotationComposer,
          $$HydrationLogsTableTableCreateCompanionBuilder,
          $$HydrationLogsTableTableUpdateCompanionBuilder,
          (
            HydrationLogsTableData,
            BaseReferences<
              _$AppDatabase,
              $HydrationLogsTableTable,
              HydrationLogsTableData
            >,
          ),
          HydrationLogsTableData,
          PrefetchHooks Function()
        > {
  $$HydrationLogsTableTableTableManager(
    _$AppDatabase db,
    $HydrationLogsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HydrationLogsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HydrationLogsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HydrationLogsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<double> originalAmountValue = const Value.absent(),
                Value<VolumeUnit> originalAmountUnit = const Value.absent(),
                Value<double> canonicalMilliliters = const Value.absent(),
                Value<DateTime> loggedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HydrationLogsTableCompanion(
                id: id,
                originalAmountValue: originalAmountValue,
                originalAmountUnit: originalAmountUnit,
                canonicalMilliliters: canonicalMilliliters,
                loggedAt: loggedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required double originalAmountValue,
                required VolumeUnit originalAmountUnit,
                required double canonicalMilliliters,
                required DateTime loggedAt,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => HydrationLogsTableCompanion.insert(
                id: id,
                originalAmountValue: originalAmountValue,
                originalAmountUnit: originalAmountUnit,
                canonicalMilliliters: canonicalMilliliters,
                loggedAt: loggedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HydrationLogsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HydrationLogsTableTable,
      HydrationLogsTableData,
      $$HydrationLogsTableTableFilterComposer,
      $$HydrationLogsTableTableOrderingComposer,
      $$HydrationLogsTableTableAnnotationComposer,
      $$HydrationLogsTableTableCreateCompanionBuilder,
      $$HydrationLogsTableTableUpdateCompanionBuilder,
      (
        HydrationLogsTableData,
        BaseReferences<
          _$AppDatabase,
          $HydrationLogsTableTable,
          HydrationLogsTableData
        >,
      ),
      HydrationLogsTableData,
      PrefetchHooks Function()
    >;
typedef $$SavedMealsTableTableCreateCompanionBuilder =
    SavedMealsTableCompanion Function({
      required String id,
      required String name,
      Value<String?> notes,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$SavedMealsTableTableUpdateCompanionBuilder =
    SavedMealsTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$SavedMealsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SavedMealsTableTable,
          SavedMealsTableData
        > {
  $$SavedMealsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $SavedMealItemsTableTable,
    List<SavedMealItemsTableData>
  >
  _savedMealItemsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.savedMealItemsTable,
        aliasName: $_aliasNameGenerator(
          db.savedMealsTable.id,
          db.savedMealItemsTable.savedMealId,
        ),
      );

  $$SavedMealItemsTableTableProcessedTableManager get savedMealItemsTableRefs {
    final manager = $$SavedMealItemsTableTableTableManager(
      $_db,
      $_db.savedMealItemsTable,
    ).filter((f) => f.savedMealId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _savedMealItemsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SavedMealsTableTableFilterComposer
    extends Composer<_$AppDatabase, $SavedMealsTableTable> {
  $$SavedMealsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> savedMealItemsTableRefs(
    Expression<bool> Function($$SavedMealItemsTableTableFilterComposer f) f,
  ) {
    final $$SavedMealItemsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.savedMealItemsTable,
      getReferencedColumn: (t) => t.savedMealId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SavedMealItemsTableTableFilterComposer(
            $db: $db,
            $table: $db.savedMealItemsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SavedMealsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SavedMealsTableTable> {
  $$SavedMealsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SavedMealsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SavedMealsTableTable> {
  $$SavedMealsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> savedMealItemsTableRefs<T extends Object>(
    Expression<T> Function($$SavedMealItemsTableTableAnnotationComposer a) f,
  ) {
    final $$SavedMealItemsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.savedMealItemsTable,
          getReferencedColumn: (t) => t.savedMealId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SavedMealItemsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.savedMealItemsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$SavedMealsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SavedMealsTableTable,
          SavedMealsTableData,
          $$SavedMealsTableTableFilterComposer,
          $$SavedMealsTableTableOrderingComposer,
          $$SavedMealsTableTableAnnotationComposer,
          $$SavedMealsTableTableCreateCompanionBuilder,
          $$SavedMealsTableTableUpdateCompanionBuilder,
          (SavedMealsTableData, $$SavedMealsTableTableReferences),
          SavedMealsTableData,
          PrefetchHooks Function({bool savedMealItemsTableRefs})
        > {
  $$SavedMealsTableTableTableManager(
    _$AppDatabase db,
    $SavedMealsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SavedMealsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SavedMealsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SavedMealsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SavedMealsTableCompanion(
                id: id,
                name: name,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => SavedMealsTableCompanion.insert(
                id: id,
                name: name,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SavedMealsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({savedMealItemsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (savedMealItemsTableRefs) db.savedMealItemsTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (savedMealItemsTableRefs)
                    await $_getPrefetchedData<
                      SavedMealsTableData,
                      $SavedMealsTableTable,
                      SavedMealItemsTableData
                    >(
                      currentTable: table,
                      referencedTable: $$SavedMealsTableTableReferences
                          ._savedMealItemsTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$SavedMealsTableTableReferences(
                            db,
                            table,
                            p0,
                          ).savedMealItemsTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.savedMealId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SavedMealsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SavedMealsTableTable,
      SavedMealsTableData,
      $$SavedMealsTableTableFilterComposer,
      $$SavedMealsTableTableOrderingComposer,
      $$SavedMealsTableTableAnnotationComposer,
      $$SavedMealsTableTableCreateCompanionBuilder,
      $$SavedMealsTableTableUpdateCompanionBuilder,
      (SavedMealsTableData, $$SavedMealsTableTableReferences),
      SavedMealsTableData,
      PrefetchHooks Function({bool savedMealItemsTableRefs})
    >;
typedef $$SavedMealItemsTableTableCreateCompanionBuilder =
    SavedMealItemsTableCompanion Function({
      required String id,
      required String savedMealId,
      required String foodId,
      required double originalQuantityValue,
      required FoodQuantityUnit originalQuantityUnit,
      Value<double?> canonicalQuantityGrams,
      Value<double?> canonicalQuantityMilliliters,
      required int orderIndex,
      Value<String?> notes,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$SavedMealItemsTableTableUpdateCompanionBuilder =
    SavedMealItemsTableCompanion Function({
      Value<String> id,
      Value<String> savedMealId,
      Value<String> foodId,
      Value<double> originalQuantityValue,
      Value<FoodQuantityUnit> originalQuantityUnit,
      Value<double?> canonicalQuantityGrams,
      Value<double?> canonicalQuantityMilliliters,
      Value<int> orderIndex,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$SavedMealItemsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SavedMealItemsTableTable,
          SavedMealItemsTableData
        > {
  $$SavedMealItemsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SavedMealsTableTable _savedMealIdTable(_$AppDatabase db) =>
      db.savedMealsTable.createAlias(
        $_aliasNameGenerator(
          db.savedMealItemsTable.savedMealId,
          db.savedMealsTable.id,
        ),
      );

  $$SavedMealsTableTableProcessedTableManager get savedMealId {
    final $_column = $_itemColumn<String>('saved_meal_id')!;

    final manager = $$SavedMealsTableTableTableManager(
      $_db,
      $_db.savedMealsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_savedMealIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $FoodsTableTable _foodIdTable(_$AppDatabase db) =>
      db.foodsTable.createAlias(
        $_aliasNameGenerator(db.savedMealItemsTable.foodId, db.foodsTable.id),
      );

  $$FoodsTableTableProcessedTableManager get foodId {
    final $_column = $_itemColumn<String>('food_id')!;

    final manager = $$FoodsTableTableTableManager(
      $_db,
      $_db.foodsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_foodIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SavedMealItemsTableTableFilterComposer
    extends Composer<_$AppDatabase, $SavedMealItemsTableTable> {
  $$SavedMealItemsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get originalQuantityValue => $composableBuilder(
    column: $table.originalQuantityValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<FoodQuantityUnit, FoodQuantityUnit, String>
  get originalQuantityUnit => $composableBuilder(
    column: $table.originalQuantityUnit,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<double> get canonicalQuantityGrams => $composableBuilder(
    column: $table.canonicalQuantityGrams,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get canonicalQuantityMilliliters => $composableBuilder(
    column: $table.canonicalQuantityMilliliters,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SavedMealsTableTableFilterComposer get savedMealId {
    final $$SavedMealsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.savedMealId,
      referencedTable: $db.savedMealsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SavedMealsTableTableFilterComposer(
            $db: $db,
            $table: $db.savedMealsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FoodsTableTableFilterComposer get foodId {
    final $$FoodsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodId,
      referencedTable: $db.foodsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodsTableTableFilterComposer(
            $db: $db,
            $table: $db.foodsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SavedMealItemsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SavedMealItemsTableTable> {
  $$SavedMealItemsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get originalQuantityValue => $composableBuilder(
    column: $table.originalQuantityValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originalQuantityUnit => $composableBuilder(
    column: $table.originalQuantityUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get canonicalQuantityGrams => $composableBuilder(
    column: $table.canonicalQuantityGrams,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get canonicalQuantityMilliliters =>
      $composableBuilder(
        column: $table.canonicalQuantityMilliliters,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SavedMealsTableTableOrderingComposer get savedMealId {
    final $$SavedMealsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.savedMealId,
      referencedTable: $db.savedMealsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SavedMealsTableTableOrderingComposer(
            $db: $db,
            $table: $db.savedMealsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FoodsTableTableOrderingComposer get foodId {
    final $$FoodsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodId,
      referencedTable: $db.foodsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodsTableTableOrderingComposer(
            $db: $db,
            $table: $db.foodsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SavedMealItemsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SavedMealItemsTableTable> {
  $$SavedMealItemsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get originalQuantityValue => $composableBuilder(
    column: $table.originalQuantityValue,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<FoodQuantityUnit, String>
  get originalQuantityUnit => $composableBuilder(
    column: $table.originalQuantityUnit,
    builder: (column) => column,
  );

  GeneratedColumn<double> get canonicalQuantityGrams => $composableBuilder(
    column: $table.canonicalQuantityGrams,
    builder: (column) => column,
  );

  GeneratedColumn<double> get canonicalQuantityMilliliters =>
      $composableBuilder(
        column: $table.canonicalQuantityMilliliters,
        builder: (column) => column,
      );

  GeneratedColumn<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$SavedMealsTableTableAnnotationComposer get savedMealId {
    final $$SavedMealsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.savedMealId,
      referencedTable: $db.savedMealsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SavedMealsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.savedMealsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FoodsTableTableAnnotationComposer get foodId {
    final $$FoodsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodId,
      referencedTable: $db.foodsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.foodsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SavedMealItemsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SavedMealItemsTableTable,
          SavedMealItemsTableData,
          $$SavedMealItemsTableTableFilterComposer,
          $$SavedMealItemsTableTableOrderingComposer,
          $$SavedMealItemsTableTableAnnotationComposer,
          $$SavedMealItemsTableTableCreateCompanionBuilder,
          $$SavedMealItemsTableTableUpdateCompanionBuilder,
          (SavedMealItemsTableData, $$SavedMealItemsTableTableReferences),
          SavedMealItemsTableData,
          PrefetchHooks Function({bool savedMealId, bool foodId})
        > {
  $$SavedMealItemsTableTableTableManager(
    _$AppDatabase db,
    $SavedMealItemsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SavedMealItemsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SavedMealItemsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$SavedMealItemsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> savedMealId = const Value.absent(),
                Value<String> foodId = const Value.absent(),
                Value<double> originalQuantityValue = const Value.absent(),
                Value<FoodQuantityUnit> originalQuantityUnit =
                    const Value.absent(),
                Value<double?> canonicalQuantityGrams = const Value.absent(),
                Value<double?> canonicalQuantityMilliliters =
                    const Value.absent(),
                Value<int> orderIndex = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SavedMealItemsTableCompanion(
                id: id,
                savedMealId: savedMealId,
                foodId: foodId,
                originalQuantityValue: originalQuantityValue,
                originalQuantityUnit: originalQuantityUnit,
                canonicalQuantityGrams: canonicalQuantityGrams,
                canonicalQuantityMilliliters: canonicalQuantityMilliliters,
                orderIndex: orderIndex,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String savedMealId,
                required String foodId,
                required double originalQuantityValue,
                required FoodQuantityUnit originalQuantityUnit,
                Value<double?> canonicalQuantityGrams = const Value.absent(),
                Value<double?> canonicalQuantityMilliliters =
                    const Value.absent(),
                required int orderIndex,
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => SavedMealItemsTableCompanion.insert(
                id: id,
                savedMealId: savedMealId,
                foodId: foodId,
                originalQuantityValue: originalQuantityValue,
                originalQuantityUnit: originalQuantityUnit,
                canonicalQuantityGrams: canonicalQuantityGrams,
                canonicalQuantityMilliliters: canonicalQuantityMilliliters,
                orderIndex: orderIndex,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SavedMealItemsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({savedMealId = false, foodId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (savedMealId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.savedMealId,
                                referencedTable:
                                    $$SavedMealItemsTableTableReferences
                                        ._savedMealIdTable(db),
                                referencedColumn:
                                    $$SavedMealItemsTableTableReferences
                                        ._savedMealIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (foodId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.foodId,
                                referencedTable:
                                    $$SavedMealItemsTableTableReferences
                                        ._foodIdTable(db),
                                referencedColumn:
                                    $$SavedMealItemsTableTableReferences
                                        ._foodIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SavedMealItemsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SavedMealItemsTableTable,
      SavedMealItemsTableData,
      $$SavedMealItemsTableTableFilterComposer,
      $$SavedMealItemsTableTableOrderingComposer,
      $$SavedMealItemsTableTableAnnotationComposer,
      $$SavedMealItemsTableTableCreateCompanionBuilder,
      $$SavedMealItemsTableTableUpdateCompanionBuilder,
      (SavedMealItemsTableData, $$SavedMealItemsTableTableReferences),
      SavedMealItemsTableData,
      PrefetchHooks Function({bool savedMealId, bool foodId})
    >;
typedef $$RemindersTableTableCreateCompanionBuilder =
    RemindersTableCompanion Function({
      required String id,
      required ReminderType type,
      required String title,
      required String timeOfDay,
      Value<bool> isEnabled,
      Value<bool> isUserDisabled,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$RemindersTableTableUpdateCompanionBuilder =
    RemindersTableCompanion Function({
      Value<String> id,
      Value<ReminderType> type,
      Value<String> title,
      Value<String> timeOfDay,
      Value<bool> isEnabled,
      Value<bool> isUserDisabled,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$RemindersTableTableFilterComposer
    extends Composer<_$AppDatabase, $RemindersTableTable> {
  $$RemindersTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ReminderType, ReminderType, String> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timeOfDay => $composableBuilder(
    column: $table.timeOfDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isUserDisabled => $composableBuilder(
    column: $table.isUserDisabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RemindersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RemindersTableTable> {
  $$RemindersTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timeOfDay => $composableBuilder(
    column: $table.timeOfDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isUserDisabled => $composableBuilder(
    column: $table.isUserDisabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RemindersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RemindersTableTable> {
  $$RemindersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ReminderType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get timeOfDay =>
      $composableBuilder(column: $table.timeOfDay, builder: (column) => column);

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<bool> get isUserDisabled => $composableBuilder(
    column: $table.isUserDisabled,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$RemindersTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RemindersTableTable,
          RemindersTableData,
          $$RemindersTableTableFilterComposer,
          $$RemindersTableTableOrderingComposer,
          $$RemindersTableTableAnnotationComposer,
          $$RemindersTableTableCreateCompanionBuilder,
          $$RemindersTableTableUpdateCompanionBuilder,
          (
            RemindersTableData,
            BaseReferences<
              _$AppDatabase,
              $RemindersTableTable,
              RemindersTableData
            >,
          ),
          RemindersTableData,
          PrefetchHooks Function()
        > {
  $$RemindersTableTableTableManager(
    _$AppDatabase db,
    $RemindersTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RemindersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RemindersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RemindersTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<ReminderType> type = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> timeOfDay = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<bool> isUserDisabled = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RemindersTableCompanion(
                id: id,
                type: type,
                title: title,
                timeOfDay: timeOfDay,
                isEnabled: isEnabled,
                isUserDisabled: isUserDisabled,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required ReminderType type,
                required String title,
                required String timeOfDay,
                Value<bool> isEnabled = const Value.absent(),
                Value<bool> isUserDisabled = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => RemindersTableCompanion.insert(
                id: id,
                type: type,
                title: title,
                timeOfDay: timeOfDay,
                isEnabled: isEnabled,
                isUserDisabled: isUserDisabled,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RemindersTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RemindersTableTable,
      RemindersTableData,
      $$RemindersTableTableFilterComposer,
      $$RemindersTableTableOrderingComposer,
      $$RemindersTableTableAnnotationComposer,
      $$RemindersTableTableCreateCompanionBuilder,
      $$RemindersTableTableUpdateCompanionBuilder,
      (
        RemindersTableData,
        BaseReferences<_$AppDatabase, $RemindersTableTable, RemindersTableData>,
      ),
      RemindersTableData,
      PrefetchHooks Function()
    >;
typedef $$HealthProfilesTableTableCreateCompanionBuilder =
    HealthProfilesTableCompanion Function({
      required String id,
      Value<String> healthConditions,
      Value<String> medications,
      Value<String> allergies,
      Value<String?> notes,
      Value<int> checkInCadenceHours,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$HealthProfilesTableTableUpdateCompanionBuilder =
    HealthProfilesTableCompanion Function({
      Value<String> id,
      Value<String> healthConditions,
      Value<String> medications,
      Value<String> allergies,
      Value<String?> notes,
      Value<int> checkInCadenceHours,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$HealthProfilesTableTableFilterComposer
    extends Composer<_$AppDatabase, $HealthProfilesTableTable> {
  $$HealthProfilesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get healthConditions => $composableBuilder(
    column: $table.healthConditions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get medications => $composableBuilder(
    column: $table.medications,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get allergies => $composableBuilder(
    column: $table.allergies,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get checkInCadenceHours => $composableBuilder(
    column: $table.checkInCadenceHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HealthProfilesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $HealthProfilesTableTable> {
  $$HealthProfilesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get healthConditions => $composableBuilder(
    column: $table.healthConditions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get medications => $composableBuilder(
    column: $table.medications,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get allergies => $composableBuilder(
    column: $table.allergies,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get checkInCadenceHours => $composableBuilder(
    column: $table.checkInCadenceHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HealthProfilesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $HealthProfilesTableTable> {
  $$HealthProfilesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get healthConditions => $composableBuilder(
    column: $table.healthConditions,
    builder: (column) => column,
  );

  GeneratedColumn<String> get medications => $composableBuilder(
    column: $table.medications,
    builder: (column) => column,
  );

  GeneratedColumn<String> get allergies =>
      $composableBuilder(column: $table.allergies, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get checkInCadenceHours => $composableBuilder(
    column: $table.checkInCadenceHours,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$HealthProfilesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HealthProfilesTableTable,
          HealthProfilesTableData,
          $$HealthProfilesTableTableFilterComposer,
          $$HealthProfilesTableTableOrderingComposer,
          $$HealthProfilesTableTableAnnotationComposer,
          $$HealthProfilesTableTableCreateCompanionBuilder,
          $$HealthProfilesTableTableUpdateCompanionBuilder,
          (
            HealthProfilesTableData,
            BaseReferences<
              _$AppDatabase,
              $HealthProfilesTableTable,
              HealthProfilesTableData
            >,
          ),
          HealthProfilesTableData,
          PrefetchHooks Function()
        > {
  $$HealthProfilesTableTableTableManager(
    _$AppDatabase db,
    $HealthProfilesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HealthProfilesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HealthProfilesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$HealthProfilesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> healthConditions = const Value.absent(),
                Value<String> medications = const Value.absent(),
                Value<String> allergies = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> checkInCadenceHours = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HealthProfilesTableCompanion(
                id: id,
                healthConditions: healthConditions,
                medications: medications,
                allergies: allergies,
                notes: notes,
                checkInCadenceHours: checkInCadenceHours,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String> healthConditions = const Value.absent(),
                Value<String> medications = const Value.absent(),
                Value<String> allergies = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> checkInCadenceHours = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => HealthProfilesTableCompanion.insert(
                id: id,
                healthConditions: healthConditions,
                medications: medications,
                allergies: allergies,
                notes: notes,
                checkInCadenceHours: checkInCadenceHours,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HealthProfilesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HealthProfilesTableTable,
      HealthProfilesTableData,
      $$HealthProfilesTableTableFilterComposer,
      $$HealthProfilesTableTableOrderingComposer,
      $$HealthProfilesTableTableAnnotationComposer,
      $$HealthProfilesTableTableCreateCompanionBuilder,
      $$HealthProfilesTableTableUpdateCompanionBuilder,
      (
        HealthProfilesTableData,
        BaseReferences<
          _$AppDatabase,
          $HealthProfilesTableTable,
          HealthProfilesTableData
        >,
      ),
      HealthProfilesTableData,
      PrefetchHooks Function()
    >;
typedef $$HealthSyncRecordsTableTableCreateCompanionBuilder =
    HealthSyncRecordsTableCompanion Function({
      required String id,
      required SyncSource source,
      required String recordType,
      Value<String?> externalId,
      required String payloadJson,
      required DateTime recordedAt,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$HealthSyncRecordsTableTableUpdateCompanionBuilder =
    HealthSyncRecordsTableCompanion Function({
      Value<String> id,
      Value<SyncSource> source,
      Value<String> recordType,
      Value<String?> externalId,
      Value<String> payloadJson,
      Value<DateTime> recordedAt,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$HealthSyncRecordsTableTableFilterComposer
    extends Composer<_$AppDatabase, $HealthSyncRecordsTableTable> {
  $$HealthSyncRecordsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SyncSource, SyncSource, String> get source =>
      $composableBuilder(
        column: $table.source,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get recordType => $composableBuilder(
    column: $table.recordType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get externalId => $composableBuilder(
    column: $table.externalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HealthSyncRecordsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $HealthSyncRecordsTableTable> {
  $$HealthSyncRecordsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recordType => $composableBuilder(
    column: $table.recordType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get externalId => $composableBuilder(
    column: $table.externalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HealthSyncRecordsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $HealthSyncRecordsTableTable> {
  $$HealthSyncRecordsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SyncSource, String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get recordType => $composableBuilder(
    column: $table.recordType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get externalId => $composableBuilder(
    column: $table.externalId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$HealthSyncRecordsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HealthSyncRecordsTableTable,
          HealthSyncRecordsTableData,
          $$HealthSyncRecordsTableTableFilterComposer,
          $$HealthSyncRecordsTableTableOrderingComposer,
          $$HealthSyncRecordsTableTableAnnotationComposer,
          $$HealthSyncRecordsTableTableCreateCompanionBuilder,
          $$HealthSyncRecordsTableTableUpdateCompanionBuilder,
          (
            HealthSyncRecordsTableData,
            BaseReferences<
              _$AppDatabase,
              $HealthSyncRecordsTableTable,
              HealthSyncRecordsTableData
            >,
          ),
          HealthSyncRecordsTableData,
          PrefetchHooks Function()
        > {
  $$HealthSyncRecordsTableTableTableManager(
    _$AppDatabase db,
    $HealthSyncRecordsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HealthSyncRecordsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$HealthSyncRecordsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$HealthSyncRecordsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<SyncSource> source = const Value.absent(),
                Value<String> recordType = const Value.absent(),
                Value<String?> externalId = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<DateTime> recordedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HealthSyncRecordsTableCompanion(
                id: id,
                source: source,
                recordType: recordType,
                externalId: externalId,
                payloadJson: payloadJson,
                recordedAt: recordedAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required SyncSource source,
                required String recordType,
                Value<String?> externalId = const Value.absent(),
                required String payloadJson,
                required DateTime recordedAt,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => HealthSyncRecordsTableCompanion.insert(
                id: id,
                source: source,
                recordType: recordType,
                externalId: externalId,
                payloadJson: payloadJson,
                recordedAt: recordedAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HealthSyncRecordsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HealthSyncRecordsTableTable,
      HealthSyncRecordsTableData,
      $$HealthSyncRecordsTableTableFilterComposer,
      $$HealthSyncRecordsTableTableOrderingComposer,
      $$HealthSyncRecordsTableTableAnnotationComposer,
      $$HealthSyncRecordsTableTableCreateCompanionBuilder,
      $$HealthSyncRecordsTableTableUpdateCompanionBuilder,
      (
        HealthSyncRecordsTableData,
        BaseReferences<
          _$AppDatabase,
          $HealthSyncRecordsTableTable,
          HealthSyncRecordsTableData
        >,
      ),
      HealthSyncRecordsTableData,
      PrefetchHooks Function()
    >;
typedef $$HealthStatusLogsTableTableCreateCompanionBuilder =
    HealthStatusLogsTableCompanion Function({
      required String id,
      required HealthEntryType type,
      required String title,
      required int severity,
      required DateTime loggedAt,
      Value<DateTime?> startedAt,
      Value<DateTime?> resolvedAt,
      Value<int?> energyLevel,
      Value<String?> bodyArea,
      Value<String> symptomTags,
      Value<String?> possibleTrigger,
      Value<String?> notes,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$HealthStatusLogsTableTableUpdateCompanionBuilder =
    HealthStatusLogsTableCompanion Function({
      Value<String> id,
      Value<HealthEntryType> type,
      Value<String> title,
      Value<int> severity,
      Value<DateTime> loggedAt,
      Value<DateTime?> startedAt,
      Value<DateTime?> resolvedAt,
      Value<int?> energyLevel,
      Value<String?> bodyArea,
      Value<String> symptomTags,
      Value<String?> possibleTrigger,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$HealthStatusLogsTableTableFilterComposer
    extends Composer<_$AppDatabase, $HealthStatusLogsTableTable> {
  $$HealthStatusLogsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<HealthEntryType, HealthEntryType, String>
  get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get severity => $composableBuilder(
    column: $table.severity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get resolvedAt => $composableBuilder(
    column: $table.resolvedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get energyLevel => $composableBuilder(
    column: $table.energyLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bodyArea => $composableBuilder(
    column: $table.bodyArea,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get symptomTags => $composableBuilder(
    column: $table.symptomTags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get possibleTrigger => $composableBuilder(
    column: $table.possibleTrigger,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HealthStatusLogsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $HealthStatusLogsTableTable> {
  $$HealthStatusLogsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get severity => $composableBuilder(
    column: $table.severity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get resolvedAt => $composableBuilder(
    column: $table.resolvedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get energyLevel => $composableBuilder(
    column: $table.energyLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bodyArea => $composableBuilder(
    column: $table.bodyArea,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get symptomTags => $composableBuilder(
    column: $table.symptomTags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get possibleTrigger => $composableBuilder(
    column: $table.possibleTrigger,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HealthStatusLogsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $HealthStatusLogsTableTable> {
  $$HealthStatusLogsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<HealthEntryType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get severity =>
      $composableBuilder(column: $table.severity, builder: (column) => column);

  GeneratedColumn<DateTime> get loggedAt =>
      $composableBuilder(column: $table.loggedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get resolvedAt => $composableBuilder(
    column: $table.resolvedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get energyLevel => $composableBuilder(
    column: $table.energyLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bodyArea =>
      $composableBuilder(column: $table.bodyArea, builder: (column) => column);

  GeneratedColumn<String> get symptomTags => $composableBuilder(
    column: $table.symptomTags,
    builder: (column) => column,
  );

  GeneratedColumn<String> get possibleTrigger => $composableBuilder(
    column: $table.possibleTrigger,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$HealthStatusLogsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HealthStatusLogsTableTable,
          HealthStatusLogsTableData,
          $$HealthStatusLogsTableTableFilterComposer,
          $$HealthStatusLogsTableTableOrderingComposer,
          $$HealthStatusLogsTableTableAnnotationComposer,
          $$HealthStatusLogsTableTableCreateCompanionBuilder,
          $$HealthStatusLogsTableTableUpdateCompanionBuilder,
          (
            HealthStatusLogsTableData,
            BaseReferences<
              _$AppDatabase,
              $HealthStatusLogsTableTable,
              HealthStatusLogsTableData
            >,
          ),
          HealthStatusLogsTableData,
          PrefetchHooks Function()
        > {
  $$HealthStatusLogsTableTableTableManager(
    _$AppDatabase db,
    $HealthStatusLogsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HealthStatusLogsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$HealthStatusLogsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$HealthStatusLogsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<HealthEntryType> type = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> severity = const Value.absent(),
                Value<DateTime> loggedAt = const Value.absent(),
                Value<DateTime?> startedAt = const Value.absent(),
                Value<DateTime?> resolvedAt = const Value.absent(),
                Value<int?> energyLevel = const Value.absent(),
                Value<String?> bodyArea = const Value.absent(),
                Value<String> symptomTags = const Value.absent(),
                Value<String?> possibleTrigger = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HealthStatusLogsTableCompanion(
                id: id,
                type: type,
                title: title,
                severity: severity,
                loggedAt: loggedAt,
                startedAt: startedAt,
                resolvedAt: resolvedAt,
                energyLevel: energyLevel,
                bodyArea: bodyArea,
                symptomTags: symptomTags,
                possibleTrigger: possibleTrigger,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required HealthEntryType type,
                required String title,
                required int severity,
                required DateTime loggedAt,
                Value<DateTime?> startedAt = const Value.absent(),
                Value<DateTime?> resolvedAt = const Value.absent(),
                Value<int?> energyLevel = const Value.absent(),
                Value<String?> bodyArea = const Value.absent(),
                Value<String> symptomTags = const Value.absent(),
                Value<String?> possibleTrigger = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => HealthStatusLogsTableCompanion.insert(
                id: id,
                type: type,
                title: title,
                severity: severity,
                loggedAt: loggedAt,
                startedAt: startedAt,
                resolvedAt: resolvedAt,
                energyLevel: energyLevel,
                bodyArea: bodyArea,
                symptomTags: symptomTags,
                possibleTrigger: possibleTrigger,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HealthStatusLogsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HealthStatusLogsTableTable,
      HealthStatusLogsTableData,
      $$HealthStatusLogsTableTableFilterComposer,
      $$HealthStatusLogsTableTableOrderingComposer,
      $$HealthStatusLogsTableTableAnnotationComposer,
      $$HealthStatusLogsTableTableCreateCompanionBuilder,
      $$HealthStatusLogsTableTableUpdateCompanionBuilder,
      (
        HealthStatusLogsTableData,
        BaseReferences<
          _$AppDatabase,
          $HealthStatusLogsTableTable,
          HealthStatusLogsTableData
        >,
      ),
      HealthStatusLogsTableData,
      PrefetchHooks Function()
    >;
typedef $$InsightsTableTableCreateCompanionBuilder =
    InsightsTableCompanion Function({
      required String id,
      required InsightCategory category,
      required InsightSeverity severity,
      required InsightStatus status,
      required String title,
      required String shortMessage,
      required String fullExplanation,
      required String evidenceJson,
      required double confidence,
      required String suggestedAction,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$InsightsTableTableUpdateCompanionBuilder =
    InsightsTableCompanion Function({
      Value<String> id,
      Value<InsightCategory> category,
      Value<InsightSeverity> severity,
      Value<InsightStatus> status,
      Value<String> title,
      Value<String> shortMessage,
      Value<String> fullExplanation,
      Value<String> evidenceJson,
      Value<double> confidence,
      Value<String> suggestedAction,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$InsightsTableTableFilterComposer
    extends Composer<_$AppDatabase, $InsightsTableTable> {
  $$InsightsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<InsightCategory, InsightCategory, String>
  get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<InsightSeverity, InsightSeverity, String>
  get severity => $composableBuilder(
    column: $table.severity,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<InsightStatus, InsightStatus, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shortMessage => $composableBuilder(
    column: $table.shortMessage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullExplanation => $composableBuilder(
    column: $table.fullExplanation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get evidenceJson => $composableBuilder(
    column: $table.evidenceJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get suggestedAction => $composableBuilder(
    column: $table.suggestedAction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InsightsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $InsightsTableTable> {
  $$InsightsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get severity => $composableBuilder(
    column: $table.severity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shortMessage => $composableBuilder(
    column: $table.shortMessage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullExplanation => $composableBuilder(
    column: $table.fullExplanation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get evidenceJson => $composableBuilder(
    column: $table.evidenceJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get suggestedAction => $composableBuilder(
    column: $table.suggestedAction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InsightsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $InsightsTableTable> {
  $$InsightsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<InsightCategory, String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumnWithTypeConverter<InsightSeverity, String> get severity =>
      $composableBuilder(column: $table.severity, builder: (column) => column);

  GeneratedColumnWithTypeConverter<InsightStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get shortMessage => $composableBuilder(
    column: $table.shortMessage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fullExplanation => $composableBuilder(
    column: $table.fullExplanation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get evidenceJson => $composableBuilder(
    column: $table.evidenceJson,
    builder: (column) => column,
  );

  GeneratedColumn<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumn<String> get suggestedAction => $composableBuilder(
    column: $table.suggestedAction,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$InsightsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InsightsTableTable,
          InsightsTableData,
          $$InsightsTableTableFilterComposer,
          $$InsightsTableTableOrderingComposer,
          $$InsightsTableTableAnnotationComposer,
          $$InsightsTableTableCreateCompanionBuilder,
          $$InsightsTableTableUpdateCompanionBuilder,
          (
            InsightsTableData,
            BaseReferences<
              _$AppDatabase,
              $InsightsTableTable,
              InsightsTableData
            >,
          ),
          InsightsTableData,
          PrefetchHooks Function()
        > {
  $$InsightsTableTableTableManager(_$AppDatabase db, $InsightsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InsightsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InsightsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InsightsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<InsightCategory> category = const Value.absent(),
                Value<InsightSeverity> severity = const Value.absent(),
                Value<InsightStatus> status = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> shortMessage = const Value.absent(),
                Value<String> fullExplanation = const Value.absent(),
                Value<String> evidenceJson = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<String> suggestedAction = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InsightsTableCompanion(
                id: id,
                category: category,
                severity: severity,
                status: status,
                title: title,
                shortMessage: shortMessage,
                fullExplanation: fullExplanation,
                evidenceJson: evidenceJson,
                confidence: confidence,
                suggestedAction: suggestedAction,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required InsightCategory category,
                required InsightSeverity severity,
                required InsightStatus status,
                required String title,
                required String shortMessage,
                required String fullExplanation,
                required String evidenceJson,
                required double confidence,
                required String suggestedAction,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => InsightsTableCompanion.insert(
                id: id,
                category: category,
                severity: severity,
                status: status,
                title: title,
                shortMessage: shortMessage,
                fullExplanation: fullExplanation,
                evidenceJson: evidenceJson,
                confidence: confidence,
                suggestedAction: suggestedAction,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InsightsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InsightsTableTable,
      InsightsTableData,
      $$InsightsTableTableFilterComposer,
      $$InsightsTableTableOrderingComposer,
      $$InsightsTableTableAnnotationComposer,
      $$InsightsTableTableCreateCompanionBuilder,
      $$InsightsTableTableUpdateCompanionBuilder,
      (
        InsightsTableData,
        BaseReferences<_$AppDatabase, $InsightsTableTable, InsightsTableData>,
      ),
      InsightsTableData,
      PrefetchHooks Function()
    >;
typedef $$AppSettingsTableTableCreateCompanionBuilder =
    AppSettingsTableCompanion Function({
      required String key,
      required String value,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$AppSettingsTableTableUpdateCompanionBuilder =
    AppSettingsTableCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$AppSettingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTableTable> {
  $$AppSettingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTableTable> {
  $$AppSettingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTableTable> {
  $$AppSettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AppSettingsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTableTable,
          AppSettingsTableData,
          $$AppSettingsTableTableFilterComposer,
          $$AppSettingsTableTableOrderingComposer,
          $$AppSettingsTableTableAnnotationComposer,
          $$AppSettingsTableTableCreateCompanionBuilder,
          $$AppSettingsTableTableUpdateCompanionBuilder,
          (
            AppSettingsTableData,
            BaseReferences<
              _$AppDatabase,
              $AppSettingsTableTable,
              AppSettingsTableData
            >,
          ),
          AppSettingsTableData,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableTableManager(
    _$AppDatabase db,
    $AppSettingsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsTableCompanion(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsTableCompanion.insert(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTableTable,
      AppSettingsTableData,
      $$AppSettingsTableTableFilterComposer,
      $$AppSettingsTableTableOrderingComposer,
      $$AppSettingsTableTableAnnotationComposer,
      $$AppSettingsTableTableCreateCompanionBuilder,
      $$AppSettingsTableTableUpdateCompanionBuilder,
      (
        AppSettingsTableData,
        BaseReferences<
          _$AppDatabase,
          $AppSettingsTableTable,
          AppSettingsTableData
        >,
      ),
      AppSettingsTableData,
      PrefetchHooks Function()
    >;
typedef $$SyncQueueTableTableCreateCompanionBuilder =
    SyncQueueTableCompanion Function({
      required String accountId,
      required SyncDomain domain,
      required SyncQueueOperation operation,
      Value<SyncQueueStatus> status,
      required DateTime queuedAt,
      required DateTime updatedAt,
      Value<DateTime?> lastAttemptAt,
      Value<DateTime?> lastSuccessAt,
      Value<String?> lastError,
      Value<int> retryCount,
      Value<int> rowid,
    });
typedef $$SyncQueueTableTableUpdateCompanionBuilder =
    SyncQueueTableCompanion Function({
      Value<String> accountId,
      Value<SyncDomain> domain,
      Value<SyncQueueOperation> operation,
      Value<SyncQueueStatus> status,
      Value<DateTime> queuedAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> lastAttemptAt,
      Value<DateTime?> lastSuccessAt,
      Value<String?> lastError,
      Value<int> retryCount,
      Value<int> rowid,
    });

class $$SyncQueueTableTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueTableTable> {
  $$SyncQueueTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SyncDomain, SyncDomain, String> get domain =>
      $composableBuilder(
        column: $table.domain,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<SyncQueueOperation, SyncQueueOperation, String>
  get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<SyncQueueStatus, SyncQueueStatus, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get queuedAt => $composableBuilder(
    column: $table.queuedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSuccessAt => $composableBuilder(
    column: $table.lastSuccessAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncQueueTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueTableTable> {
  $$SyncQueueTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get domain => $composableBuilder(
    column: $table.domain,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get queuedAt => $composableBuilder(
    column: $table.queuedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSuccessAt => $composableBuilder(
    column: $table.lastSuccessAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncQueueTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueTableTable> {
  $$SyncQueueTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SyncDomain, String> get domain =>
      $composableBuilder(column: $table.domain, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SyncQueueOperation, String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SyncQueueStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get queuedAt =>
      $composableBuilder(column: $table.queuedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastSuccessAt => $composableBuilder(
    column: $table.lastSuccessAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => column,
  );
}

class $$SyncQueueTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncQueueTableTable,
          SyncQueueTableData,
          $$SyncQueueTableTableFilterComposer,
          $$SyncQueueTableTableOrderingComposer,
          $$SyncQueueTableTableAnnotationComposer,
          $$SyncQueueTableTableCreateCompanionBuilder,
          $$SyncQueueTableTableUpdateCompanionBuilder,
          (
            SyncQueueTableData,
            BaseReferences<
              _$AppDatabase,
              $SyncQueueTableTable,
              SyncQueueTableData
            >,
          ),
          SyncQueueTableData,
          PrefetchHooks Function()
        > {
  $$SyncQueueTableTableTableManager(
    _$AppDatabase db,
    $SyncQueueTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> accountId = const Value.absent(),
                Value<SyncDomain> domain = const Value.absent(),
                Value<SyncQueueOperation> operation = const Value.absent(),
                Value<SyncQueueStatus> status = const Value.absent(),
                Value<DateTime> queuedAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> lastAttemptAt = const Value.absent(),
                Value<DateTime?> lastSuccessAt = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncQueueTableCompanion(
                accountId: accountId,
                domain: domain,
                operation: operation,
                status: status,
                queuedAt: queuedAt,
                updatedAt: updatedAt,
                lastAttemptAt: lastAttemptAt,
                lastSuccessAt: lastSuccessAt,
                lastError: lastError,
                retryCount: retryCount,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String accountId,
                required SyncDomain domain,
                required SyncQueueOperation operation,
                Value<SyncQueueStatus> status = const Value.absent(),
                required DateTime queuedAt,
                required DateTime updatedAt,
                Value<DateTime?> lastAttemptAt = const Value.absent(),
                Value<DateTime?> lastSuccessAt = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncQueueTableCompanion.insert(
                accountId: accountId,
                domain: domain,
                operation: operation,
                status: status,
                queuedAt: queuedAt,
                updatedAt: updatedAt,
                lastAttemptAt: lastAttemptAt,
                lastSuccessAt: lastSuccessAt,
                lastError: lastError,
                retryCount: retryCount,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncQueueTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncQueueTableTable,
      SyncQueueTableData,
      $$SyncQueueTableTableFilterComposer,
      $$SyncQueueTableTableOrderingComposer,
      $$SyncQueueTableTableAnnotationComposer,
      $$SyncQueueTableTableCreateCompanionBuilder,
      $$SyncQueueTableTableUpdateCompanionBuilder,
      (
        SyncQueueTableData,
        BaseReferences<_$AppDatabase, $SyncQueueTableTable, SyncQueueTableData>,
      ),
      SyncQueueTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableTableManager get usersTable =>
      $$UsersTableTableTableManager(_db, _db.usersTable);
  $$GoalsTableTableTableManager get goalsTable =>
      $$GoalsTableTableTableManager(_db, _db.goalsTable);
  $$ExercisesTableTableTableManager get exercisesTable =>
      $$ExercisesTableTableTableManager(_db, _db.exercisesTable);
  $$WorkoutTemplatesTableTableTableManager get workoutTemplatesTable =>
      $$WorkoutTemplatesTableTableTableManager(_db, _db.workoutTemplatesTable);
  $$WorkoutTemplateItemsTableTableTableManager get workoutTemplateItemsTable =>
      $$WorkoutTemplateItemsTableTableTableManager(
        _db,
        _db.workoutTemplateItemsTable,
      );
  $$WorkoutSessionsTableTableTableManager get workoutSessionsTable =>
      $$WorkoutSessionsTableTableTableManager(_db, _db.workoutSessionsTable);
  $$WorkoutExerciseEntriesTableTableTableManager
  get workoutExerciseEntriesTable =>
      $$WorkoutExerciseEntriesTableTableTableManager(
        _db,
        _db.workoutExerciseEntriesTable,
      );
  $$SetEntriesTableTableTableManager get setEntriesTable =>
      $$SetEntriesTableTableTableManager(_db, _db.setEntriesTable);
  $$BodyLogsTableTableTableManager get bodyLogsTable =>
      $$BodyLogsTableTableTableManager(_db, _db.bodyLogsTable);
  $$FoodsTableTableTableManager get foodsTable =>
      $$FoodsTableTableTableManager(_db, _db.foodsTable);
  $$FoodPortionsTableTableTableManager get foodPortionsTable =>
      $$FoodPortionsTableTableTableManager(_db, _db.foodPortionsTable);
  $$MealEntriesTableTableTableManager get mealEntriesTable =>
      $$MealEntriesTableTableTableManager(_db, _db.mealEntriesTable);
  $$HydrationLogsTableTableTableManager get hydrationLogsTable =>
      $$HydrationLogsTableTableTableManager(_db, _db.hydrationLogsTable);
  $$SavedMealsTableTableTableManager get savedMealsTable =>
      $$SavedMealsTableTableTableManager(_db, _db.savedMealsTable);
  $$SavedMealItemsTableTableTableManager get savedMealItemsTable =>
      $$SavedMealItemsTableTableTableManager(_db, _db.savedMealItemsTable);
  $$RemindersTableTableTableManager get remindersTable =>
      $$RemindersTableTableTableManager(_db, _db.remindersTable);
  $$HealthProfilesTableTableTableManager get healthProfilesTable =>
      $$HealthProfilesTableTableTableManager(_db, _db.healthProfilesTable);
  $$HealthSyncRecordsTableTableTableManager get healthSyncRecordsTable =>
      $$HealthSyncRecordsTableTableTableManager(
        _db,
        _db.healthSyncRecordsTable,
      );
  $$HealthStatusLogsTableTableTableManager get healthStatusLogsTable =>
      $$HealthStatusLogsTableTableTableManager(_db, _db.healthStatusLogsTable);
  $$InsightsTableTableTableManager get insightsTable =>
      $$InsightsTableTableTableManager(_db, _db.insightsTable);
  $$AppSettingsTableTableTableManager get appSettingsTable =>
      $$AppSettingsTableTableTableManager(_db, _db.appSettingsTable);
  $$SyncQueueTableTableTableManager get syncQueueTable =>
      $$SyncQueueTableTableTableManager(_db, _db.syncQueueTable);
}
