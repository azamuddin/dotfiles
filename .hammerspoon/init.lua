hs.loadSpoon('Countdown');
hs.loadSpoon('Seal');
table.filter = function(t, filterIter)
  local out = {}

  for k, v in pairs(t) do
    if filterIter(v, k, t) then table.insert(out, v) end
  end

  return out
end

-- end utils

wf = hs.window.filter.new()
all_windows = {} -- global all_windows

function onWindowCreated(win)
  --table.insert(all_windows, win);
  all_windows[win:id()] = win;
end

function onWindowDestroyed(win)
  --all_windows = table.filter(all_windows, function(item)
    --return item:id() ~= win:id();
  --end)
  all_windows[win:id()] = nil;
end

wf:subscribe(hs.window.filter.windowCreated, onWindowCreated)
wf:subscribe(hs.window.filter.windowDestroyed, onWindowDestroyed)


function registerWFtoAllWindows()
  local windows = wf:getWindows();

  if windows == nil then return end;
  
  for key, window in pairs(windows) do
    all_windows[window:id()] = window;
  end
end

function getWindowsAsChoices()
   registerWFtoAllWindows()
   local results = {};
   local results_win = {};
   for key,window in pairs(all_windows) do 
     table.insert(results, {
        text = window:application():name(),
        id = window:id(),
        subText = window:title()
      })
     results_win[window:id()] = window;
   end
   return {results, results_win}
end

function chooseWindow(information)
  if information == nil then return end;
  local results_win = getWindowsAsChoices()[2];
  local selectedWin = results_win[information.id];
  selectedWin:focus();
end

function chooser()
  local cs = hs.chooser.new(chooseWindow):width(60):show();
  local results = getWindowsAsChoices()[1]
  cs:choices(results);
end

hs.hotkey.bind({"shift","ctrl"}, "R", chooser)
hs.hotkey.bind({"shift", "ctrl"}, "U", function()
  state, minutes = hs.dialog.textPrompt('Starts for (minutes)', 'how many minutes', '25');
  spoon.Countdown:startFor(minutes);
end)

-- web search
spoon.Seal:loadPlugins({"urlformats", "useractions", "apps"})
spoon.Seal:bindHotkeys({show={{"ctrl", "shift"}, "Y"}})
spoon.Seal.plugins.apps:start();
spoon.Seal:start();

spoon.Seal.plugins.useractions.actions = {
    ["Google"] = { url = "https://www.google.com/search?q=${query}", keyword="gg" },
}

