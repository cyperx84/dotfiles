-- Test script for mini.nvim modules
-- Run with: nvim --headless -c "luafile ~/.config/nvim/lua/custom/test_mini.lua" -c "qa"

local function test_module(name, tests)
  local ok, module = pcall(require, name)

  print(string.format("\n=== Testing %s ===", name))

  if not ok then
    print(string.format("❌ FAILED: Module '%s' not loaded", name))
    print("   Error: " .. tostring(module))
    return false
  end

  print(string.format("✅ Module '%s' loaded successfully", name))

  -- Run additional tests if provided
  if tests then
    for test_name, test_func in pairs(tests) do
      local success, err = pcall(test_func, module)
      if success then
        print(string.format("  ✅ %s", test_name))
      else
        print(string.format("  ❌ %s: %s", test_name, tostring(err)))
        return false
      end
    end
  end

  return true
end

local results = {}

-- Test mini.ai
results['mini.ai'] = test_module('mini.ai', {
  ['Config exists'] = function(m)
    assert(m.config ~= nil, "Config not found")
    assert(m.config.n_lines == 500, "n_lines config incorrect")
  end,
})

-- Test mini.surround
results['mini.surround'] = test_module('mini.surround', {
  ['Config exists'] = function(m)
    assert(m.config ~= nil, "Config not found")
    assert(m.config.mappings ~= nil, "Mappings not configured")
  end,
  ['Mappings set'] = function(m)
    assert(m.config.mappings.add == 'sa', "Add mapping incorrect")
    assert(m.config.mappings.delete == 'sd', "Delete mapping incorrect")
    assert(m.config.mappings.replace == 'sr', "Replace mapping incorrect")
  end,
})

-- Test mini.sessions
results['mini.sessions'] = test_module('mini.sessions', {
  ['Config exists'] = function(m)
    assert(m.config ~= nil, "Config not found")
    assert(m.config.autoread == true, "Autoread not enabled")
    assert(m.config.autowrite == true, "Autowrite not enabled")
  end,
})

-- Test mini.statusline
results['mini.statusline'] = test_module('mini.statusline', {
  ['Config exists'] = function(m)
    assert(m.config ~= nil, "Config not found")
  end,
})

-- Test mini.files
results['mini.files'] = test_module('mini.files', {
  ['Config exists'] = function(m)
    assert(m.config ~= nil, "Config not found")
    assert(m.config.options.use_as_default_explorer == true, "Not set as default explorer")
  end,
  ['Mappings configured'] = function(m)
    assert(m.config.mappings.close == 'q', "Close mapping incorrect")
    assert(m.config.mappings.go_in == 'l', "Go in mapping incorrect")
  end,
})

-- Test mini.pick
results['mini.pick'] = test_module('mini.pick', {
  ['Config exists'] = function(m)
    assert(m.config ~= nil, "Config not found")
  end,
})

-- Test mini.colors
results['mini.colors'] = test_module('mini.colors', {
  ['Config exists'] = function(m)
    assert(m.config ~= nil, "Config not found")
  end,
})

-- Test mini.diff
results['mini.diff'] = test_module('mini.diff', {
  ['Config exists'] = function(m)
    assert(m.config ~= nil, "Config not found")
    assert(m.config.view ~= nil, "View config not found")
    assert(m.config.view.style == 'sign', "View style not set to 'sign'")
  end,
})

-- Summary
print("\n" .. string.rep("=", 50))
print("SUMMARY")
print(string.rep("=", 50))

local passed = 0
local failed = 0

for module, result in pairs(results) do
  if result then
    passed = passed + 1
  else
    failed = failed + 1
  end
end

print(string.format("\nTotal: %d modules", passed + failed))
print(string.format("✅ Passed: %d", passed))
print(string.format("❌ Failed: %d", failed))

if failed == 0 then
  print("\n🎉 All mini.nvim modules are working correctly!")
else
  print("\n⚠️  Some modules have issues. Please review the output above.")
  os.exit(1)
end
