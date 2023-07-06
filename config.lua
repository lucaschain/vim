require("user.plugins")

require('text-to-colorscheme').setup {
  ai = {
    openai_api_key = os.getenv("OPENAI_API_KEY"),
    gpt_model = "gpt-3.5-turbo"
  },
}

require("user.csharp")
require("user.code_cleaning")
require("user.testing")
