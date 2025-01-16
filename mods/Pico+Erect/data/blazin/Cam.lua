function onUpdate()
setProperty('defaultCamZoom',1.3)
doTweenZoom('camz1','camGame', 1.3, 0.01,'sineInOut')
    triggerEvent('Camera Follow Pos', 1250, 1400)
end