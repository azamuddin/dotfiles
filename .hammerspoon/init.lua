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

    if(string.match(window:title(), 'incognito')) then 
      -- do nothing 
    else 
      all_windows[window:id()] = window;
    end
  end
end

function getWindowsAsChoices()
   registerWFtoAllWindows()
   local results = {};
   local results_win = {};
   for key,window in pairs(all_windows) do 
     table.insert(results, {
        id = window:id(),
        text = window:application():name():gsub('^%l', string.upper) .. ' :: ' .. window:title(), 
        subText = window:application():name():gsub('^%l', string.upper),
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
  local cs = hs.chooser.new(chooseWindow):width(50):show();
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










-- TOP BAR RELATED


leftTopBarItems = nil;
rightTopBarItems = nil;
topBarBg = nil;

function drawFocusedApp(title)

  if(leftTopBarItems) then leftTopBarItems:delete() end
  if(topBarBg) then topBarBg:delete() end
  if(rightTopBarItems) then rightTopBarItems:delete() end

  if title == nil then 
    title = hs.application.frontmostApplication():name()
  end

  title = title:gsub('^%l', string.upper)

  local mainScreen = hs.screen.mainScreen(); 
  local mainRes = mainScreen:fullFrame(); 

  local boxFrame = hs.geometry.rect(0, -2, mainRes.w, 25)
  topBarBg = hs.drawing.rectangle(boxFrame);
  topBarBg:setFill(true)
  topBarBg:setFillColor({red=0.0, blue=0.0, green=0.0, alpha=0.8})
  topBarBg:setLevel(hs.drawing.windowLevels.modalPanel)
  topBarBg:show();

  local leftText = hs.styledtext
    .new("  🚀 "..title.." · ".. os.date('%H:%M'), 
      {
        font={name="Hack Nerd Font",size=14}, 
        color={red=1, blue=1, green=1},
        ligature=2,
        paragraphStyle={lineSpacing=0.5}
      }
    )

  local rightText = hs.styledtext
   .new("··· azamuddin ··· ", 
     {
        font={name="Hack Nerd Font",size=14}, 
        color={red=1, blue=1, green=1},
        ligature=2,
        paragraphStyle={lineSpacing=0.5, alignment="center"}
     }
   )

  local frame = hs.geometry.rect(0,0, mainRes.w, 40)

  leftTopBarItems = hs.drawing.text(frame, leftText);
  leftTopBarItems:setLevel(hs.drawing.windowLevels.modalPanel)
  leftTopBarItems:show();

  rightTopBarItems = hs.drawing.text(frame, rightText)
  rightTopBarItems:setLevel(hs.drawing.windowLevels.modalPanel)
  rightTopBarItems:show();

end

everySeconds = hs.timer.doEvery(1, drawFocusedApp)
everySeconds:start()

-- application watcher
function watchApp(name, event, app)

  if event == hs.application.watcher.activated then
    drawFocusedApp(app:name())
  end
end

appWatcher = hs.application.watcher.new(watchApp)
appWatcher:start()

-- end application watcher

-- END TOP BAR RELATED

