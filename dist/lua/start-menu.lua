local c = vim.F.if_nil
local d = vim.fn.fnamemodify
local e = vim.fn.filereadable
local f = {
	type = "text",
	val = {
		[[ _   _                       _             _ ]],
		[[| \ | |                     (_)           | |]],
		[[|  \| | _   _   __ _ __   __ _  _ __ ___  | |]],
		[[| . ` || | | | / _` |\ \ / /| || '_ ` _ \ | |]],
		[[| |\  || |_| || (_| | \ V / | || | | | | ||_|]],
		[[\_| \_/ \__, | \__,_|  \_/  |_||_| |_| |_|(_)]],
		[[         __/ |                               ]],
		[[        |___/                                ]],
	},
	opts = { position = "left", hl = "Type", shrink_margin = false },
}
local g = "SPC"
local function h(i, j, k, l)
	local m = i:gsub("%s", ""):gsub(g, "<leader>")
	local n = {
		position = "left",
		shortcut = "[" .. i .. "] ",
		cursor = 1,
		width = 50,
		align_shortcut = "left",
		hl_shortcut = { { "Operator", 0, 1 }, { "Number", 1, #i + 1 }, { "Operator", #i + 1, #i + 2 } },
		shrink_margin = false,
	}
	if k then
		l = c(l, { noremap = true, silent = true, nowait = true })
		n.keymap = { "n", m, k, { noremap = false, silent = true, nowait = true } }
	end
	local function o()
		local p = vim.api.nvim_replace_termcodes(k .. "<Ignore>", true, false, true)
		vim.api.nvim_feedkeys(p, "t", false)
	end
	return { type = "button", val = j, on_press = o, opts = n }
end

local q = { enabled = true, highlight = true }
local function r(s)
	local t = s:match("^.+(%..+)$")
	local u = ""
	if t ~= nil then
		u = t:sub(2)
	end
	return u
end

local function v(s)
	local w = require("nvim-web-devicons")
	local u = r(s)
	return w.get_icon(s, u, { default = true })
end

local function x(s, i, y, z)
	y = c(y, s)
	local A
	local B = {}
	if q.enabled then
		local C, D = v(s)
		local E = type(q.highlight)
		if E == "boolean" then
			if D and q.highlight then
				table.insert(B, { D, 0, 1 })
			end
		end
		if E == "string" then
			table.insert(B, { q.highlight, 0, 1 })
		end
		A = C .. "  "
	else
		A = ""
	end
	local F = z and " | cd %:p:h" or ""
	local G = h(i, A .. y, "<cmd>e " .. s .. F .. " <CR>")
	local H = y:match(".*[/\\]")
	if H ~= nil then
		table.insert(B, { "Comment", #A - 2, #H + #A - 2 })
	end
	G.opts.hl = B
	return G
end

local I = { "gitcommit" }
local J = {
	ignore = function(K, u)
		return string.find(K, "COMMIT_EDITMSG") or vim.tbl_contains(I, u)
	end,
	autocd = false,
}
local function L(M, N, O, n)
	n = n or J
	O = c(O, 10)
	local P = {}
	for Q, R in pairs(vim.v.oldfiles) do
		if #P == O then
			break
		end
		local S
		if not N then
			S = true
		else
			S = vim.startswith(R, N)
		end
		local T = n.ignore and n.ignore(R, r(R)) or false
		if e(R) == 1 and S and not T then
			P[#P + 1] = R
		end
	end
	local U = {}
	for V, s in ipairs(P) do
		local y
		if N then
			y = d(s, ":.")
		else
			y = d(s, ":~")
		end
		local G = x(s, tostring(V + M - 1), y, n.autocd)
		U[V] = G
	end
	return { type = "group", val = U, opts = { position = "left" } }
end

local function W()
	return "Recent in " .. vim.fn.getcwd()
end

local X = {
	header = f,
	top_buttons = { type = "group", val = { h("e", "New file", "<cmd>ene <CR>") } },
	mru = {
		type = "group",
		val = {
			{ type = "padding", val = 1 },
			{ type = "text", val = "Recent (All Directories)", opts = { hl = "SpecialComment", position = "left" } },
			{ type = "padding", val = 1 },
			{
				type = "group",
				val = function()
					return { L(10) }
				end,
			},
		},
	},
	mru_cwd = {
		type = "group",
		val = {
			{ type = "padding", val = 1 },
			{ type = "text", val = W, opts = { hl = "SpecialComment", shrink_margin = false, position = "left" } },
			{ type = "padding", val = 1 },
			{
				type = "group",
				val = function()
					return { L(0, vim.fn.getcwd()) }
				end,
				opts = { shrink_margin = false },
			},
		},
	},
	bottom_buttons = { type = "group", val = { h("q", "Quit", "<cmd>q <CR>") } },
	footer = { type = "group", val = {} },
}
require("alpha").setup({
	layout = {
		{ type = "padding", val = 1 },
		X.header,
		{ type = "padding", val = 2 },
		X.top_buttons,
		X.mru_cwd,
		X.mru,
		{ type = "padding", val = 1 },
		X.bottom_buttons,
		X.footer,
	},
	opts = {
		margin = 3,
		redraw_on_resize = false,
		setup = function()
			vim.api.nvim_create_autocmd({ "DirChanged", "VimResized" }, {
				pattern = "*",
				callback = function()
					require("alpha").redraw()
				end,
			})
		end,
	},
})
