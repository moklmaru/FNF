luaDebugMode = true
local dadName = 'spooky' -- Nombre del personaje que imita a Dad
local bfName = 'nene' -- Nombre del personaje que imita a Boyfriend
local gfName = 'pico-mix' -- Nombre del personaje que imita a Girlfriend

-- Posiciones y configuraciones de cada personaje
local xDad, yDad = getProperty('dad.x'), getProperty('dad.y') -- Posición del personaje Dad
local xBF, yBF = 434, -8 + 100 -- Posición del personaje BF
local xGF, yGF = 1000, getProperty('boyfriend.y') -- Posición del personaje GF
local isPlayerDad, isPlayerBF, isPlayerGF = false, false, true -- Configuración del lado del jugador
local orderDad, orderBF, orderGF = 10, 11, 12 -- Órdenes de capa para cada personaje

-- Crear instancias de los personajes
createInstance(dadName, 'objects.Character', {xDad, yDad, dadName, isPlayerDad})
createInstance(bfName, 'objects.Character', {xBF, yBF, bfName, isPlayerBF})
createInstance(gfName, 'objects.Character', {xGF, yGF, gfName, isPlayerGF})
setProperty(dadName..'.alpha', 0)
setProperty(bfName..'.alpha', 0)
setProperty(gfName..'.alpha', 0)

if orderDad <= -1 then
    addInstance(dadName)
else
    setObjectOrder(dadName, orderDad)
end

if orderBF <= -1 then
    addInstance(bfName)
else
    setObjectOrder(bfName, orderBF)
end

if orderGF <= -1 then
    addInstance(gfName)
else
    setObjectOrder(gfName, orderGF)
end

-- Funciones de baile y animación durante el countdown y beats
function onCountdownTick(counter)
    if getProperty(dadName..'.danceIdle') or counter % 2 == 0 then
        callMethod(dadName..'.dance', {''})
    end
    if getProperty(bfName..'.danceIdle') or counter % 2 == 0 then
        callMethod(bfName..'.dance', {''})
    end
    if getProperty(gfName..'.danceIdle') or counter % 2 == 0 then
        callMethod(gfName..'.dance', {''})
    end
end

function onBeatHit()
    if curBeat % getProperty(dadName..'.danceEveryNumBeats') == 0 and not stringStartsWith(getProperty(dadName..'.animation.name'), 'sing') and not getProperty(dadName..'.stunned') then
        callMethod(dadName..'.dance', {''})
    end
    if curBeat % getProperty(bfName..'.danceEveryNumBeats') == 0 and not stringStartsWith(getProperty(bfName..'.animation.name'), 'sing') and not getProperty(bfName..'.stunned') then
        callMethod(bfName..'.dance', {''})
    end
    if curBeat % getProperty(gfName..'.danceEveryNumBeats') == 0 and not stringStartsWith(getProperty(gfName..'.animation.name'), 'sing') and not getProperty(gfName..'.stunned') then
        callMethod(gfName..'.dance', {''})
    end
end

-- Función para animaciones de los personajes clonados (spooky para opponentNoteHit, pico-mix para goodNoteHit)
function extraNoteHit(isOpponent, d, miss)
    if isOpponent then
        -- Activar animación de spooky cuando sea un opponentNoteHit
        playAnim(dadName, getProperty('singAnimations')[d + 1]..(miss and 'miss' or ''), true)
        setProperty(dadName..'.holdTimer', 0)
    else
        -- Activar animación de pico-mix cuando sea un goodNoteHit
        playAnim(gfName, getProperty('singAnimations')[d + 1]..(miss and 'miss' or ''), true)
        setProperty(gfName..'.holdTimer', 0)
    end
end

-- Eventos de hit o miss para cada
function goodNoteHit(_, d)
    extraNoteHit(false, d, false) 
end

function opponentNoteHit(_, d)
    extraNoteHit(true, d, false) 
end

function noteMiss(_, d)
    extraNoteHit(false, d, true) 
end

-- Función para detectar cuando una animación termina y volver a idle
function onUpdate(elapsed)
    if getProperty(gfName..'.animation.curAnim.finished') and stringStartsWith(getProperty(gfName..'.animation.name'), 'sing') then
        -- Reproducir la animación idle después de que la animación 'sing' haya terminado
        playAnim(gfName, 'idle', true)
    end

    -- Repetir el mismo proceso para el personaje Dad si es necesario
    if getProperty(dadName..'.animation.curAnim.finished') and stringStartsWith(getProperty(dadName..'.animation.name'), 'sing') then
        playAnim(dadName, 'idle', true)
    end
end
