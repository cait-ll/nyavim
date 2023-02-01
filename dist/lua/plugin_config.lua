require("start-menu")

require("nvim-treesitter.configs").setup({
	auto_install = true,
	highlight = { enable = true },
	refactor = { highlight_definitions = { enable = true, clear_on_cursor_move = true } },
	autotag = { enable = true },
})

require("treesitter-context").setup()

require("nvim-dap-virtual-text").setup()

local ts = require("telescope")
ts.setup()
pcall(require("telescope").load_extension, "fzf")

require("icon-picker").setup({ disable_legacy_commands = true })
require("dressing").setup()
require("indent_blankline").setup({
	show_end_of_line = true,
	space_char_blankline = " ",
	show_current_context = true,
	show_current_context_start = true,
})
require("pretty-fold").setup({
	sections = { left = { "content" }, right = { " ", "number_of_folded_lines", " •••" } },
})
require("fidget").setup()
require("tokyonight").setup({
	style = "moon",
	terminal_colors = true,
	styles = { comments = { italic = true }, keywords = { italic = true } },
	sidebars = { "qf", "help", "packer", "which-key" },
})
vim.cmd([[colorscheme tokyonight]])
require("twilight").setup({ dimming = { alpha = 0.5 } })
vim.g.coq_settings = { auto_start = true }
local Z = require("lspconfig")
local _ = require("rust-tools")
local a0 = require("null-ls")
local a1 = require("typescript")
local cmp = require("cmp")
local function a2(a3, a4) end

local function a5(a3, a4)
	_.inlay_hints.enable()
end

require("mason").setup()
require("mason-nvim-dap").setup({
	ensure_installed = { "codelldb", "firefox", "kotlin", "delve" },
	automatic_setup = true,
})
local a6 = {
	"cmake",
	"cssls",
	"dockerls",
	"graphql",
	"kotlin_language_server",
	"pyright",
	"sumneko_lua",
	"taplo",
	"tsserver",
	"volar",
	"yamlls",
	"zls",
}
require("mason-lspconfig").setup({ ensure_installed = a6, automatic_installation = true })
table.remove(a6, 12)

local luasnip = require("luasnip")

luasnip.snippets = require("luasnip_snippets").load_snippets()

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		["<CR>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				local entry = cmp.get_selected_entry()
				if entry then
					cmp.confirm()
				else
					fallback()
				end
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i" }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
			else
				fallback()
			end
		end, { "i" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
			else
				fallback()
			end
		end, { "i" }),
		["<S-Down>"] = cmp.mapping.scroll_docs(4),
		["<S-Up>"] = cmp.mapping.scroll_docs(-4),
	},
	window = {
		completion = {
			winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
			col_offset = -3,
			side_padding = 0,
		},
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
			local strings = vim.split(kind.kind, "%s", { trimempty = true })
			kind.kind = " " .. (strings[1] or "") .. " "
			kind.menu = "    (" .. (strings[2] or "") .. ")"

			return kind
		end,
	},
	sources = {
		{ name = "luasnip" },
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "emoji" },
		{ name = "buffer" },
	},
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

for Q, a7 in ipairs(a6) do
	Z[a7].setup({ capabilities = capabilities })
end
_.setup({ tools = { hover_actions = { auto_focus = true } }, server = { on_attach = a5 } })
a1.setup({ server = { on_attach = a2 } })
a0.setup({
	sources = {
		a0.builtins.formatting.stylua,
		a0.builtins.diagnostics.clazy,
		a0.builtins.formatting.asmfmt,
		a0.builtins.formatting.autopep8,
		a0.builtins.formatting.clang_format,
		a0.builtins.formatting.cmake_format,
		a0.builtins.formatting.gofmt,
		a0.builtins.formatting.markdown_toc,
		a0.builtins.formatting.prettierd,
		a0.builtins.formatting.qmlformat,
		a0.builtins.formatting.rustfmt,
		a0.builtins.formatting.zigfmt,
	},
})
require("vgit").setup()
require("neodev").setup({ library = { plugins = { "nvim-dap-ui" }, types = true } })
require("dapui").setup()
require("project_nvim").setup()
require("telescope").load_extension("projects")
require("nvim-autopairs").setup({ check_ts = true })
local a8 = function()
	local a9 = require("tokyonight.colors").setup({ transform = true })
	local aa = require("tokyonight.config").options
	local ab = {}
	ab.normal = {
		a = { bg = a9.blue, fg = a9.black },
		b = { bg = a9.fg_gutter, fg = a9.blue },
		c = { bg = a9.bg_statusline, fg = a9.fg_sidebar },
	}
	ab.insert = { a = { bg = a9.green, fg = a9.black }, b = { bg = a9.fg_gutter, fg = a9.green } }
	ab.command = { a = { bg = a9.yellow, fg = a9.black }, b = { bg = a9.fg_gutter, fg = a9.yellow } }
	ab.visual = { a = { bg = a9.magenta, fg = a9.black }, b = { bg = a9.fg_gutter, fg = a9.magenta } }
	ab.replace = { a = { bg = a9.red, fg = a9.black }, b = { bg = a9.fg_gutter, fg = a9.red } }
	ab.terminal = { a = { bg = a9.green1, fg = a9.black }, b = { bg = a9.fg_gutter, fg = a9.green1 } }
	ab.inactive = {
		a = { bg = a9.bg_statusline, fg = a9.blue },
		b = { bg = a9.bg_statusline, fg = a9.fg_gutter, gui = "bold" },
		c = { bg = a9.bg_statusline, fg = a9.fg_gutter },
	}
	if aa.lualine_bold then
		for Q, ac in pairs(ab) do
			ac.a.gui = "bold"
		end
	end
	return ab
end
require("lualine").setup({
	options = {
		theme = a8(),
		ignore_focus = { "NvimTree" },
		disabled_filetypes = { statusline = {}, winbar = {}, tabline = {}, ["NvimTree"] = {} },
	},
})
require("nvim-tree").setup({
	filters = {
		dotfiles = true,
	},
})
local legend = require("legendary")
local tsb = require("telescope.builtin")
local hover_menu = function()
	if vim.bo.filetype == "rust" then
		require("rust-tools").hover_actions.hover_actions()
	else
		vim.lsp.buf.hover()
	end
end
local code_action_menu = function()
	if vim.bo.filetype == "rust" then
		require("rust-tools").code_action_group.code_action_group()
	else
		vim.lsp.buf.code_action()
	end
end

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

require("scope").setup()

require("bufferline").setup({
	options = {
		diagnostics = "nvim_lsp",
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Manager",
				text_align = "center",
				separator = true,
			},
		},
		indicator = {
			style = "underline",
		},
	},
})

local pick = require("telescope.pickers")
local fd = require("telescope.finders")
local tsconf = require("telescope.config").values
local tsact = require("telescope.actions")
local tsact_state = require("telescope.actions.state")
local rt_actions = {}
rt_actions["Join Lines"] = _.join_lines.join_lines
rt_actions["Expand Macro"] = _.expand_macro.expand_macro
rt_actions["Open Cargo.toml"] = _.open_cargo_toml.open_cargo_toml
rt_actions["Go To Parent Module"] = _.parent_module.parent_module
rt_actions["Run"] = _.runnables.runnables
local rust_tools_menu = function(n)
	n = n or {}
	if not n.theme then
		n = require("telescope.themes").get_cursor(n)
	end
	pick.new(n, {
		prompt_title = "Rust Tools",
		finder = fd.new_table({
			results = { "Join Lines", "Expand Macro", "Open Cargo.toml", "Go To Parent Module", "Run" },
		}),
		sorter = tsconf.generic_sorter(n),
		attach_mappings = function(ao)
			tsact.select_default:replace(function()
				tsact.close(ao)
				local ap = tsact_state.get_selected_entry()[1]
				rt_actions[ap]()
			end)
			return true
		end,
	}):find()
end
local vg_actions = {
	"Open Buffer Diff",
	"Open Buffer Blame",
	"Open Buffer History",
	"Open Staged Changes",
	"Stage Changes In Buffer",
	"Unstage Changes In Buffer",
	"Revert Buffer To Version In Head",
	"Open Project Diff",
	"Open Project Logs",
	"Stage All Changes",
	"Unstage All Changes",
	"Revert All Changes",
	"Open Commit Menu",
	"Toggle Gutter Signs",
}
local vg_action_map = {
	["Open Buffer Diff"] = "buffer_diff_preview",
	["Open Buffer Blame"] = "buffer_blame_preview",
	["Open Buffer History"] = "buffer_history_preview",
	["Open Buffer Staged Changes"] = "buffer_diff_staged_preview",
	["Stage Changes In Buffer"] = "buffer_stage",
	["Unstage Changes In Buffer"] = "buffer_unstage",
	["Revert Buffer To Version In Head"] = "buffer_reset",
	["Open Project Diff"] = "project_diff_preview",
	["Open Project Logs"] = "project_logs_preview",
	["Stage All Changes"] = "project_stage_all",
	["Unstage All Changes"] = "project_unstage_all",
	["Revert All Changes"] = "project_reset_all",
	["Open Commit Menu"] = "project_commit_preview",
	["Toggle Gutter Signs"] = "toggle_live_gutter",
}
local vg_menu = function()
	vim.ui.select(vg_actions, { prompt = "VGit Action Menu" }, function(cmd)
		vim.cmd("VGit " .. vg_action_map[cmd])
	end)
end
require("which-key").setup()
legend.setup({
	keymaps = {
		{ "<leader>fe", ":NvimTreeToggle<CR>", description = "Opens the file explorer window" },
		{ "<leader>ge", tsb.git_files, description = "Opens the git file explorer" },
		{ "<leader>bl", tsb.buffers, description = "Opens the buffer list" },
		{ "<leader>ff", tsb.old_files, description = "Lists previously open files" },
		{ "<leader>qf", tsb.quickfix, description = "Opens the quickfix window" },
		{
			"<leader>ld",
			tsb.lsp_definitions,
			description = "Finds the definition of the word under the cursor using LSP",
		},
		{ "<leader>D", tsb.diagnostics, description = "Opens the diagnostics window" },
		{ "<leader>gs", tsb.git_status, description = "Opens the git status window" },
		{ "<leader>db", require("dapui").toggle, description = "Toggles the debugging UI" },
		{ "<leader>h", hover_menu, description = "Opens the hover action menu/focuses if open" },
		{ "<leader>c", code_action_menu, description = "Opens the code action menu/focuses if open" },
		{ "<leader>ir", vim.lsp.buf.rename, description = "Opens the rename menu for the item under the cursor" },
		{ "<leader>tr", rust_tools_menu, description = "Opens the rust-tools.nvim menu" },
		{ "<leader>td", ":Twilight<CR>", description = "Toggles dimming of inactive code" },
		{ "<leader>lr", require("telescope").extensions.projects.projects, description = "Lists known repositories" },
		{ "<leader>sr", require("spectre").open, description = "Opens the search/replace menu" },
		{ "<leader>gm", vg_menu, description = "Opens the visual git menu" },
		{ "b<Right>", ":bnext<CR>", description = "Goes to next buffer" },
		{ "b<Left>", ":bprev<CR>", description = "Goes to previous buffer" },
		{ "<leader>bd", ":bd<CR>", description = "Closes current buffer (if unchanged)" },
	},
})
require("which-key").setup()
