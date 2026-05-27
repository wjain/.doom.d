# Doom Emacs Config (wjain/.doom.d)

Private Doom Emacs configuration. After editing `init.el` or `packages.el`, run `doom sync` then restart Emacs (or `M-x doom/reload`). All Elisp files use `-*- lexical-binding: t; -*-`.

## Key env vars (required by agent-shell agents)

- `ANTHROPIC_API_KEY` — claude-agent-acp (red-team reviewer)
- `SILICONFLOW_API_KEY` — qwen (blue-team lead, via SiliconFlow OpenAI-compatible endpoint)
Both must be exported in `~/.bashrc` and regenerated via `doom env` if needed.

## Agent Fleet (红蓝对抗)

Defined in `config.el` under `(use-package! agent-shell ...)`, lines 516-579. Four ACP agents:

| Agent   | Role    | Command              | Notes                     |
|---------|---------|----------------------|---------------------------|
| qwen    | Blue    | `qwen --acp`         | Needs SILICONFLOW_API_KEY |
| opencode| Blue    | `opencode acp`       |                           |
| codex   | Blue    | `codex-acp`          |                           |
| claude  | Red     | `claude-agent-acp`   | Needs ANTHROPIC_API_KEY   |

Important: Use `agent-shell--make-acp-client` (not raw `acp-make-client`) for all agents — required for `outgoing-request-decorator` support. Agent configs are **alists** (`((:identifier . qwen) ...)`) returned by `agent-shell-make-agent-config`. If a dispatcher errors `wrong-type-argument plistp`, the config is being treated as a plist somewhere — check config alist format.

`agent-shell-preferred-agent-config` is nil (prompts each time, no default).
`(acp-logging-enabled t)` is set; check `*acp-(agent)-N log*` / traffic buffers for debugging.

### Workflow

1. Start blue agent: `M-x agent-shell` (or `SPC o m s`), select qwen/opencode/codex
2. Generate draft in blue agent buffer
3. Red-team review: `SPC A r` → `SPC A s` → `SPC A e`
4. Fleet status: `SPC A f` (or `SPC o m d`)

### Known issues

- `gemini --acp` broken in v0.43.0 (zero stdout/stderr) — removed from fleet
- qwen ACP mode does not support interactive/slash commands (errors `Slash command not supported in ACP integration`)
- Pipe-based CLI testing (e.g. `printf '...\n...\n' | cmd`) is flawed — these agents need bidirectional coproc-style I/O (`make-process`); only `agent-shell`'s `agent-shell--initiate-handshake` path works correctly

## Configuration structure

- `init.el` — Doom module manifest (which lang/tool modules enabled)
- `packages.el` — `package!` declarations for straight.el; `-*- no-byte-compile: t; -*-`
- `config.el` — All custom settings, keybinds, fleet config
- `FLEET.org` — Primary workflow documentation for the agent fleet

## Other AI integration

`gptel` + `superchat` for interactive chat (separate from agent-shell fleet). Backends: OpenRouter, Moonshot, ChatGLM, KatCode, LongCat, Ollama, Packy Proxy. Switch via `SPC x` prefix. Do not confuse with agent-shell.

## Keybindings

| Prefix   | Area                  |
|----------|-----------------------|
| `SPC A`  | Agent fleet commands  |
| `SPC o m`| Meta-agent management |
| `SPC x`  | gptel LLM switching   |

## Qwen Code config

`~/.qwen/settings.json` configures qwen's SiliconFlow OpenAI-compatible endpoint. Do not modify unless changing API provider.

## Java / LSP

Lombok jar must exist at `/home/jain.y/.doom.d/plugin/lombok-1.18.22.jar` for `lsp-java-vmargs` to work. Not tracked in git — place manually.

## Windows notes

MSYS2 shell via `conpty_proxy.exe` for vterm on Windows. Selection coding system auto-detects UTF-16LE on Windows vs UTF-8 on Linux.
