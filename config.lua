require("user.plugins")
--require("user.csharp")
require("user.code_cleaning")
require("user.testing")
require("user.debugging")

lvim.builtin.alpha.dashboard.section.header.val = {
  "                                                                             ",
  "  ,ad8888ba,   88                                    88                      ",
  " d8''    `'8b  88                                    ''                      ",
  "d8'            88                                                            ",
  "88             88,dPPYba,   ,adPPYYba,  8b       d8  88  88,dPYba,,adPYba,   ",
  "88             88P'    '8a  ''     `Y8  `8b     d8'  88  88P'   '88'    '8a  ",
  "Y8,            88       88  ,adPPPPP88   `8b   d8'   88  88      88      88  ",
  " Y8a.    .a8P  88       88  88,    ,88    `8b,d8'    88  88      88      88  ",
  "  `'Y8888Y'    88       88  `'8bbdP'Y8      '8'      88  88      88      88  ",
  "                                                                             ",
  "                                                                             ",
}

vim.opt.relativenumber = true
vim.opt.mouse = ""
vim.opt.clipboard = "unnamedplus"

local clipboard = vim.g.clipboard

if clipboard ~= nil then
  vim.g.clipboard = {
    copy = {
      ['+'] = 'clip.exe',
      ['*'] = 'clip.exe',
    },
  }
end
