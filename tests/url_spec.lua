local oil = require("oil")
local util = require("oil.util")
describe("url", function()
  it("get_url_for_path", function()
    local cases = {
      { "", "oil://" .. util.addslash(vim.fn.getcwd()) },
      { "/foo/bar.txt", "oil:///foo/", "bar.txt" },
      { "oil:///foo/bar.txt", "oil:///foo/", "bar.txt" },
      { "oil:///", "oil:///" },
      { "scp://user@hostname:8888//bar.txt", "oil-ssh://user@hostname:8888//", "bar.txt" },
      { "oil-ssh://user@hostname:8888//", "oil-ssh://user@hostname:8888//" },
    }
    for _, case in ipairs(cases) do
      local input, expected, expected_basename = unpack(case)
      local output, basename = oil.get_buffer_parent_url(input)
      assert.equals(expected, output, string.format('Parent url for path "%s" failed', input))
      assert.equals(
        expected_basename,
        basename,
        string.format('Basename for path "%s" failed', input)
      )
    end
  end)
end)
