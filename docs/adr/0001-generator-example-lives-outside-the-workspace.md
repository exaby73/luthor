# The generator example lives outside the workspace

`luthor` and `luthor_generator` support Dart 3.11, and `luthor_generator` supports analyzer 10 to 14 (`>=10.0.0 <15.0.0`). The floor is 10 because Flutter 3.41 pins `meta` 1.17.0, and only analyzer 10.0.0 and 10.0.1 accept that `meta` (10.0.2 and later need `meta` 1.18, 13.1 and later need 1.18.3). Dropping 10 would lock Flutter 3.41 apps out of the generator.

The runnable generator example uses freezed. freezed 4 needs Dart 3.13, and the last freezed release that runs on Dart 3.11 (3.2.5) needs analyzer below 11. A pub workspace resolves one version of each package for every member. Keeping the example in the workspace would mean raising the packages' SDK floor to 3.13, or pinning the whole workspace to analyzer 10 with freezed 3, which stops the default test run from covering analyzer 13 and 14. So the example resolves on its own, with Dart 3.13 and freezed 4, through path dependencies on the two packages.

It lives in `examples/luthor_generator`, not in `packages/luthor_generator/example`. Pub resolves a workspace member's `example/` folder whenever it resolves the member, even when the example isn't listed in the workspace. With the example there, a bare `dpk get` on Dart 3.11 fails on the example's `^3.13.0` SDK constraint. `packages/luthor_generator/example/example.md` stays, with no pubspec, so pub.dev's Example tab still has content.

## Consequences

- The example has its own `.tool-versions` with a newer Flutter. `dpk get` doesn't resolve it or apply the catalog to it, so its constraints are kept by hand.
- It keeps a `dependency_overrides` entry on the path `luthor` until `luthor` 1.0.0 is published, because `luthor_generator` depends on the hosted `luthor`.
- `dpk run build` runs code generation there. No format, analyze or test script reaches into `examples/`.
- The workspace resolves analyzer 14 by default. CI covers the analyzer 10 and 13.0 floors by constraining the root `analyzer` dependency to the floor version in a separate job.
- Once the packages' SDK floor reaches Dart 3.13 and the analyzer floor reaches 13 (freezed 4 needs it), the example can rejoin the workspace.
