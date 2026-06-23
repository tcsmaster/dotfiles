return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',

  config = function()
    require('nvim-treesitter').install({
      'yaml',
      'toml',
      'python',
      'bash',
      'dockerfile',
      'rust',
      'tsx',
      'json',
      'r',
      'cmake',
      'c',
      'cpp',
      'cuda',
    })

    local function start_treesitter(buf, lang)
      if vim.treesitter.language.add(lang) then
        vim.treesitter.start(buf, lang)
      end
    end

    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local buf = args.buf
        local ft = args.match
        local lang = vim.treesitter.language.get_lang(ft)

        if not lang then
          return
        end

        -- Already installed?
        if pcall(vim.treesitter.language.add, lang) then
          start_treesitter(buf, lang)
          return
        end

        -- Try downloading it
        require('nvim-treesitter').install({ lang }):wait(function()
          vim.schedule(function()
            start_treesitter(buf, lang)
          end)
        end)
      end,
    })
  end,
}
