hs.loadSpoon('Countdown');
hs.loadSpoon('Seal');

log = hs.logger.new("azamuddin-spoon", "debug")

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

-- check if the title indicating incognito browser
function isNotIncognito(title)
  if string.match(title:lower(), 'incognito') then 
    return false
  else 
    return true
  end
end

-- add window to chooser window
function addWindowToChooser(win)

  if win == nil then 
    return 
  end

  if isNotIncognito(win:title()) then 
    all_windows[win:id()] = win
  end
end

function onWindowCreated(win)
  addWindowToChooser(win)
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
    if(string.match(window:title():lower(), 'incognito')) then 
      -- do nothing 
    else 
      addWindowToChooser(window)
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
        image = hs.image.imageFromAppBundle(window:application():bundleID())
      })
     results_win[window:id()] = window;
   end
   return {results, results_win}
end

function chooseWindow(information)
  if information == nil then return end;
  local results_win = getWindowsAsChoices()[2];
  local selectedWin = results_win[information.id];
  selectedWin:unminimize()
  selectedWin:focus()
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
centerTopBarItems = nil;
rightTopBarItems = nil;
topBarBg = nil;

function drawTopBar(title)

  if(leftTopBarItems ~= nil) then leftTopBarItems:delete() end
  if(topBarBg ~= nil) then topBarBg:delete() end
  if(centerTopBarItems ~= nil) then centerTopBarItems:delete() end
  if(rightTopBarItems ~= nil) then rightTopBarItems:delete() end

  if title == nil then 
    title = hs.application.frontmostApplication():name()
  end

  title = title:gsub('^%l', string.upper)

  local mainScreen = hs.screen.mainScreen(); 
  local mainRes = mainScreen:fullFrame(); 

  local boxFrame = hs.geometry.rect(0, -2, mainRes.w, 25)
  topBarBg = hs.drawing.rectangle(boxFrame);
  topBarBg:setFill(true)
  topBarBg:setFillColor({red=0.0, blue=0.0, green=0.0, alpha=0.7})
  topBarBg:setLevel(hs.drawing.windowLevels.modalPanel)
  topBarBg:show();

  local leftText = hs.styledtext
    .new("  🚀 "..title.." ", 
      {
        font={name="Hack Nerd Font",size=14}, 
        color={red=1, blue=1, green=1},
        ligature=2,
        paragraphStyle={lineSpacing=0.5}
      }
    )

  local centerText = hs.styledtext
   .new("··· azamuddin ··· ", 
     {
        font={name="Hack Nerd Font",size=14}, 
        color={red=1, blue=1, green=1},
        ligature=2,
        paragraphStyle={lineSpacing=0.5, alignment="center"}
     }
   )

  local rightText = hs.styledtext
  .new(os.date('%A, %d/%m/%Y · %H:%M') .. " · ", 
    {
        font={name="Hack Nerd Font",size=14}, 
        color={red=1, blue=1, green=1},
        ligature=2,
        paragraphStyle={lineSpacing=0.5, alignment="right"}
    }
  )

  local frame = hs.geometry.rect(0,0, mainRes.w, 40)

  leftTopBarItems = hs.drawing.text(frame, leftText);
  leftTopBarItems:setLevel(hs.drawing.windowLevels.modalPanel)
  leftTopBarItems:show()

  centerTopBarItems = hs.drawing.text(frame, centerText)
  centerTopBarItems:setLevel(hs.drawing.windowLevels.modalPanel)
  centerTopBarItems:show()

  rightTopBarItems = hs.drawing.text(frame, rightText) 
  rightTopBarItems:setLevel(hs.drawing.windowLevels.modalPanel)
  rightTopBarItems:show()

end

everySeconds = hs.timer.doEvery(1, drawTopBar)
everySeconds:start()

function minimiseUnfocusedWindows()
  local focused = hs.window.focusedWindow()

  if focused == nil then return end;
  
  for key, window in pairs(all_windows) do
    if window:id() == focused:id() or window == nil then 
      -- do nothing 
    else 
      window:minimize()
    end
  end
end

hs.hotkey.bind({"shift","ctrl"}, "M", minimiseUnfocusedWindows)

-- application watcher
function watchApp(name, event, app)

  -- application received focus
  if event == hs.application.watcher.activated then
    -- redraw topbar
    drawTopBar(app:name())
  end

  -- application launched
  if event == hs.application.watcher.launched then 

    local window = app:mainWindow() 
    addWindowToChooser(window)

  end

end

appWatcher = hs.application.watcher.new(watchApp)
appWatcher:start()

-- end application watcher

-- END TOP BAR RELATED

