return {
  "epwalsh/obsidian.nvim",
  version = "*",  -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
   event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    'BufReadPre '..vim.fn.expand '/mnt/d/Vault/**/*.md',
    'BufNewFile ' ..vim.fn.expand '/mnt/d/Vault/**/*.md',
   },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('obsidian').setup {
        workspaces = {
          {
            name = 'Idk',
            path = '/mnt/d/Vault/Idk',
          },
        },
        mappings = {
          -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
          ['gf'] = {
            action = function()
              return require('obsidian').util.gf_passthrough()
            end,
            opts = { noremap = false, expr = true, buffer = true },
          },
          -- create and toggle checkboxes
          ['<cr>'] = {
            action = function()
              local line = vim.api.nvim_get_current_line()
              if line:match '%s*- %[' then
                require('obsidian').util.toggle_checkbox()
              elseif line:match '%s*-' then
                vim.cmd [[s/-/- [ ]/]]
                vim.cmd.nohlsearch()
              end
            end,
            opts = { buffer = true },
          },
        },
       -- Optional, customize how names/IDs for new notes are created.
       note_id_func = function(title)
         -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
         -- In this case a note with the title 'My new note' will be given an ID that looks
         -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
         local suffix = ''
         if title ~= nil then
           -- If title is given, transform it into valid file name.
           suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
         else
           -- If title is nil, just add 4 random uppercase letters to the suffix.
           for _ = 1, 4 do
             suffix = suffix .. string.char(math.random(65, 90))
           end
         end
         return tostring(os.time()) .. '-' .. suffix
       end,
      }

      vim.wo.conceallevel = 1
    end,
  }

