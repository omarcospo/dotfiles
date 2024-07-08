local function run_cmd(cmd, show_error)
  if type(cmd) == "string" then
    cmd = vim.split(cmd, " ")
  end
  if vim.fn.has("win32") == 1 then
    cmd = vim.list_extend({ "cmd.exe", "/C" }, cmd)
  end
  local result = vim.fn.system(cmd)
  local success = vim.api.nvim_get_vvar("shell_error") == 0
  if not success and (show_error == nil or show_error) then
    vim.api.nvim_err_writeln(("Error running command %s\nError message:\n%s"):format(table.concat(cmd, " "), result))
  end
  return success and result:gsub("[\27\155][][()#;?%d]*[A-PRZcf-ntqry=><~]", "") or nil
end

local function trigger_event(event, is_urgent)
 
  local function trigger()
    local is_user_event = string.match(event, "^User ") ~= nil
    if is_user_event then
      event = event:gsub("^User ", "")
      vim.api.nvim_exec_autocmds("User", { pattern = event, modeline = false })
    else
      vim.api.nvim_exec_autocmds(event, { modeline = false })
    end
  end
  if is_urgent then
    trigger()
  else
    vim.schedule(trigger)
  end
end

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile", "BufWritePost" }, {
  desc = "Nvim user events for file detection (BaseFile and BaseGitFile)",
  callback = function(args)
    local empty_buffer = vim.fn.resolve(vim.fn.expand("%")) == ""
    local greeter = vim.api.nvim_get_option_value("filetype", { buf = args.buf }) == "alpha"
    local git_repo =
      run_cmd({ "git", "-C", vim.fn.fnamemodify(vim.fn.resolve(vim.fn.expand("%")), ":p:h"), "rev-parse" }, false)

   
    if not (empty_buffer or greeter) then
      trigger_event("User BaseFile")

     
      if git_repo then
        trigger_event("User BaseGitFile")
      end
    end
  end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  desc = "Nvim user event that trigger a few ms after nvim starts",
  callback = function()
   
    if #vim.fn.argv() >= 1 then
     
      trigger_event("User BaseDefered", true)
      trigger_event("BufEnter", true)
    else
      vim.defer_fn(function()
        trigger_event("User BaseDefered")
      end, 70)
    end
  end,
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "CodeAction",
    "checkhealth",
    "help",
    "DressingInput",
    "NeogitStatus",
    "NeogitConsole",
    "NeogitPopup",
    "fugitive",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    local options = { buffer = event.buf, silent = true }
    vim.keymap.set("n", "q", "<cmd>close<cr>", options)
    vim.keymap.set({ "n", "i" }, "<C-q>", "<cmd>close<cr>", options)
  end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- create parent directories when saving a file.
vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Automatically create parent directories if they don't exist when saving a file",
  callback = function(args)
    local buf_is_valid_and_listed = vim.api.nvim_buf_is_valid(args.buf) and vim.bo[args.buf].buflisted

    if buf_is_valid_and_listed then
      vim.fn.mkdir(vim.fn.fnamemodify(vim.loop.fs_realpath(args.match) or args.match, ":p:h"), "p")
    end
  end,
})
