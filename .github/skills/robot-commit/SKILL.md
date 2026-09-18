---
name: robot-commit
description: "Use when writing or reviewing a Git commit message for this MATLAB quadruped robot repository; classify kinematics, trajectory, plotting, hardware, and documentation changes with the project's Conventional Commit format."
---

# Robot Commit

Write commit messages for this repository using the format in `.gitmessage.txt`:

```text
<type>(<scope>): <short summary>
```

## Workflow

1. Inspect `git status --short` and `git diff --stat`. Read the relevant diff when the change type or scope is unclear.
2. Group related changes by intent. If unrelated changes are mixed together, mention that the changes should be split before proposing one message.
3. Choose the most specific applicable type from the table below.
4. Choose a short lowercase scope describing the affected project area. Prefer `matlab`, `kinematics`, `trajectory`, `plotting`, `hardware`, `docs`, or `paths`; omit the scope only when the change genuinely spans the repository.
5. Write an imperative, specific subject with a maximum length of 72 characters including the type, scope, punctuation, and spaces.
6. Add a body only when the motivation, integration detail, safety consideration, or limitation is not clear from the subject. Wrap body lines at 72 characters.
7. Add a footer only for issue references or breaking changes. Use forms such as `Closes #123` or `BREAKING CHANGE: ...`.
8. Present the proposed message in a plain text code block and briefly state the classification when useful. Do not run `git commit` unless the user explicitly asks for it.

## Types

| Type | Use for |
| --- | --- |
| `feat` | New user-facing or system capability |
| `fix` | Correction of incorrect behavior or a bug |
| `docs` | README, comments, guides, or other documentation only |
| `style` | Formatting or whitespace with no behavior change |
| `refactor` | Structural or maintainability changes without behavior change |
| `test` | Tests only |
| `chore` | Routine maintenance or repository tooling |
| `perf` | Performance improvements without behavior change |
| `build` | Build system, package manager, or deployment changes |
| `ci` | Continuous integration configuration or scripts |

Use the smallest accurate type. For example, path portability changes that alter runtime behavior are usually `fix`, while documentation-only path corrections are `docs`.

## Project Scopes

Use one of these scopes when it accurately identifies the change:

- `matlab`: general MATLAB code or shared project behavior
- `kinematics`: FK, IK, dimensions, coordinate conventions, or transforms
- `trajectory`: cubic/quintic/cycloid planning or gait timing
- `plotting`: robot, leg, workspace, or trajectory visualization
- `hardware`: Arduino, servo, pin, port, or motion-control scripts
- `docs`: README, references, diagrams, or agent guidance
- `paths`: MATLAB path or file-location changes

Do not use a scope merely to make the message longer. Use `paths` for repository/path portability fixes and the most specific component scope for a change contained in one area.

## Message Rules

- Use imperative mood: `add`, `fix`, `document`, `resolve`, `replace`, `simplify`.
- Keep the subject lowercase after the colon and do not end it with a period.
- Describe the result, not the editing process. Prefer `fix(hardware): validate servo port before motion` over `fix(hardware): change some settings`.
- Keep the subject within 72 characters. Count the complete first line, not only the summary after the colon.
- Mention repository-specific integration facts in the body when relevant, such as degree-based FK/IK inputs, normalized `writePosition` values, the Arduino Mega 2560, or the `D2`-`D9` mapping.
- Call out unverified hardware behavior, changed coordinate conventions, changed servo directions, timing assumptions, or changed file formats in the body or footer.
- Never claim that MATLAB execution, servo motion, or robot hardware was tested unless the user explicitly confirms that validation.

## Output Template

For a normal change:

```text
<type>(<scope>): <imperative summary>
```

For a change that needs context:

```text
<type>(<scope>): <imperative summary>

<motivation, important implementation detail, or validation limitation>

<optional issue or breaking-change footer>
```

