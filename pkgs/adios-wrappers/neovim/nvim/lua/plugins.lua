-- I don't have plugin manager, because lux.nvim is not ready, but I can't live without these keybings, so I am using nix to use these plugins for now
local kbd = vim.keymap.set
require("oil").setup({
	delete_to_trash = false,
	view_options = { show_hidden = true },
})
require("which-key").setup()
kbd("n", "<leader>g", "<cmd>Neogit<cr>")
kbd("n", "<leader>e", "<cmd>Oil<cr>")
kbd("n", "<leader>p", "<cmd>PasteImage<cr>")

require("neorg").setup({
	load = {
		["core.concealer"] = { ["config"] = { ["icon_preset"] = "diamond" } },
		["core.defaults"] = { ["config"] = { ["disable"] = {} }, ["enable"] = true },
		["core.dirman"] = {
			["config"] = {
				["default_workspace"] = "life",
				["workspaces"] = {
					["archive"] = "~/Documents/Norg/Archive",
					["journal"] = "~/Documents/Norg/Journal",
					["life"] = "~/Documents/Norg",
					["study"] = "~/Documents/Norg/Study",
				},
			},
		},
		["core.esupports.metagen"] = {
			["config"] = { ["timezone"] = "implicit-local", ["type"] = "empty", ["undojoin_updates"] = false },
		},
		["core.journal"] = { ["config"] = {
			["journal_folder"] = "./",

			["workspace"] = "journal",
		} },
		["core.keybinds"] = { ["config"] = { ["default_keybinds"] = true, ["neorg_leader"] = "," } },
		["core.summary"] = {},
    ["core.qol.toc"] = { config = { close_after_use = true } },
		["core.tangle"] = { ["config"] = { ["report_on_empty"] = true, ["tangle_on_write"] = false } },
	},
})

