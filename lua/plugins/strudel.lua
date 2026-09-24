return {
  {
    "gruvw/strudel.nvim",
    build = "npm ci",
    config = function()
      local strudel = require("strudel")
      strudel.setup({
        update_on_save = true,
        puppeteer = {
          args = { "--no-sandbox", "--disable-setuid-sandbox" },
        },
      })

      vim.keymap.set("n", "<leader>sl", strudel.launch, { desc = "Launch Strudel" })
      vim.keymap.set("n", "<leader>sq", strudel.quit, { desc = "Quit Strudel" })
      vim.keymap.set("n", "<leader>st", strudel.toggle, { desc = "Strudel Toggle Play/Stop" })
      vim.keymap.set("n", "<leader>su", strudel.update, { desc = "Strudel Update" })
      vim.keymap.set("n", "<leader>ss", strudel.stop, { desc = "Strudel Stop Playback" })
      vim.keymap.set("n", "<leader>sb", strudel.set_buffer, { desc = "Strudel set current buffer" })
      vim.keymap.set("n", "<leader>sx", strudel.execute, { desc = "Strudel set current buffer and update" })
    end,
  },
}
