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
        text = window:application():name() .. ' :: ' .. window:title(), 
        subText = window:application():name(),
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












-- EXPERIMENT 

mouseCircle = nil
mouseCircleTimer = nil

function mouseHighlight()
    -- Delete an existing highlight if it exists
    if mouseCircle then
        mouseCircle:delete()
        if mouseCircleTimer then
            mouseCircleTimer:stop()
        end
    end
    -- Get the current co-ordinates of the mouse pointer
    mousepoint = hs.mouse.getAbsolutePosition()
    -- Prepare a big red circle around the mouse pointer
    mouseCircle = hs.drawing.circle(hs.geometry.rect(mousepoint.x-40, mousepoint.y-40, 80, 80))
    mouseCircle:setStrokeColor({["red"]=1,["blue"]=0,["green"]=0,["alpha"]=1})
    mouseCircle:setFill(false)
    mouseCircle:setStrokeWidth(5)
    mouseCircle:show()

    -- Set a timer to delete the circle after 3 seconds
    mouseCircleTimer = hs.timer.doAfter(3, function() mouseCircle:delete() end)
end

focusedAppDrawing = nil;
focusedAppBgDrawing = nil;

function drawFocusedApp(title)

  if(focusedAppDrawing) then focusedAppDrawing:delete() end
  if(focusedAppBgDrawing) then focusedAppBgDrawing:delete() end

  local mainScreen = hs.screen.mainScreen(); 
  local mainRes = mainScreen:fullFrame(); 

  local boxFrame = hs.geometry.rect(0, -2, mainRes.w, 22)
  focusedAppBgDrawing = hs.drawing.rectangle(boxFrame);
  focusedAppBgDrawing:setFill(true)
  focusedAppBgDrawing:setFillColor({red=0.0, blue=0.0, green=0.0, alpha=0.7})
  focusedAppBgDrawing:setLevel(hs.drawing.windowLevels.modalPanel)
  focusedAppBgDrawing:show();

  text = hs.styledtext
    .new(" ·"..title.."· ", 
      {
        font={name="Hack Nerd Font",size=16}, 
        color={red=1, blue=1, green=1},
        ligature=2,
        paragraphStyle={lineSpacing=0.5}
      }
    ):lower()

  frame = hs.geometry.rect(0,-5, 300, 40)

  focusedAppDrawing = hs.drawing.text(frame, text);
  focusedAppDrawing:setLevel(hs.drawing.windowLevels.modalPanel)
  focusedAppDrawing:show();


end

-- application watcher
function watchApp(name, event, app)

  if event == hs.application.watcher.activated then
    drawFocusedApp(app:name())
  end
end

appWatcher = hs.application.watcher.new(watchApp)
appWatcher:start()

-- end application watcher

hs.hotkey.bind({"shift", "ctrl"}, "E", mouseHighlight)
