# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

## 2024-02-18

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`luthor_annotation` - `v0.3.0`](#luthor_annotation---v030)
 - [`luthor_generator` - `v0.3.2+1`](#luthor_generator---v0321)

Packages with dependency updates only:

> Packages listed below depend on other packages in this workspace that have had changes. Their versions have been incremented to bump the minimum dependency versions of the packages they depend upon in this project.

 - `luthor_generator` - `v0.3.2+1`

---

#### `luthor_annotation` - `v0.3.0`

 - **FEAT**(luthor,luthor_annotation,luthor_generator): add startsWith, endsWith and contains string validations ([#63](https://github.com/exaby73/luthor/issues/63)).
 - **FEAT**: custom validators ([#61](https://github.com/exaby73/luthor/issues/61)).
 - **FEAT**: resolved.


## 2024-02-18

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`luthor` - `v0.3.0`](#luthor---v030)

---

#### `luthor` - `v0.3.0`

 - **FEAT**(luthor,luthor_annotation,luthor_generator): add startsWith, endsWith and contains string validations ([#63](https://github.com/exaby73/luthor/issues/63)).
 - **FEAT**: custom validators ([#61](https://github.com/exaby73/luthor/issues/61)).
 - **FEAT**(luthor): consolidated int and double validator to num.
 - **FEAT**(luthor): added min and max validators for int, double and num.
 - **FEAT**: update analyzer.


## 2023-11-20

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`luthor_generator` - `v0.3.2`](#luthor_generator---v032)

---

#### `luthor_generator` - `v0.3.2`

 - **FEAT**: update analyzer.


## 2023-08-15

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`luthor_generator` - `v0.3.1`](#luthor_generator---v031)

---

#### `luthor_generator` - `v0.3.1`

 - **FEAT**(luthor_generator): add support for DateTime.


## 2023-08-13

### Changes

---

Packages with breaking changes:

 - [`luthor_generator` - `v0.3.0`](#luthor_generator---v030)

Packages with other changes:

 - There are no other changes in this release.

---

#### `luthor_generator` - `v0.3.0`

 - **FEAT**(luthor_generator): validate method generates unique methods allowing multiple luthor classes in one file.
 - **FEAT**(luthor_generator): Add support for JsonKey.name.


## 2023-07-23

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`luthor` - `v0.2.2`](#luthor---v022)
 - [`luthor_generator` - `v0.2.4`](#luthor_generator---v024)

---

#### `luthor` - `v0.2.2`

 - **FIX**: redundant calls fromJson in SchemaValidationError.
 - **FIX**(luthor): SchemaValidation null error due to covariant.
 - **FIX**(luthor): l.list() does not validate inner values correctly.
 - **FEAT**(luthor): add fromJson argument to validateSchema.

#### `luthor_generator` - `v0.2.4`

 - **FIX**: dependencies.
 - **FIX**(luthor): SchemaValidation null error due to covariant.
 - **FEAT**(luthor_generator): Add support for JsonKey.name.
 - **FEAT**(luthor_generator): luthor classes now require a validate method instead of exposing the raw schema.
 - **FEAT**(luthor): add fromJson argument to validateSchema.


## 2023-07-15

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`luthor` - `v0.2.1`](#luthor---v021)
 - [`luthor_generator` - `v0.2.3`](#luthor_generator---v023)

---

#### `luthor` - `v0.2.1`

 - **FIX**: redundant calls fromJson in SchemaValidationError.
 - **FIX**(luthor): SchemaValidation null error due to covariant.
 - **FIX**(luthor): l.list() does not validate inner values correctly.
 - **FEAT**(luthor): add fromJson argument to validateSchema.

#### `luthor_generator` - `v0.2.3`

 - **FIX**: dependencies.
 - **FIX**(luthor): SchemaValidation null error due to covariant.
 - **FEAT**(luthor_generator): luthor classes now require a validate method instead of exposing the raw schema.
 - **FEAT**(luthor): add fromJson argument to validateSchema.

