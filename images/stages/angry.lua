function onCreate()
	-- background shit
	
	makeLuaSprite('bg', 'bg', -1250, -730);
	setLuaSpriteScrollFactor('bg', 1, 1);
	scaleObject('bg', 1.9, 1.9);

	makeLuaSprite('bg2', 'bg', -1250, -730);
	setLuaSpriteScrollFactor('bg2', 1, 1);
	scaleObject('bg2', 1.9, 1.9);

	makeLuaSprite('floor', 'floor', -1250, -730);
	setLuaSpriteScrollFactor('floor', 1, 1);
	scaleObject('floor', 1.9, 1.9);

	makeAnimatedLuaSprite('fire', 'fire', -550, -130);
	setLuaSpriteScrollFactor('fire', 0.3, 1);
	scaleObject('fire', 5, 5);
	addAnimationByPrefix('fire', 'idle', 'idle', 15, true)

	-- sprites that only load if Low Quality is turned off
	if not lowQuality then
		makeLuaSprite('stagelight_left', 'stage_light', -12225, -100);
		setLuaSpriteScrollFactor('stagelight_left', 0.9, 0.9);
		scaleObject('stagelight_left', 1.1, 1.1);
		
		makeLuaSprite('stagelight_right', 'stage_light', 12225, -100);
		setLuaSpriteScrollFactor('stagelight_right', 0.9, 0.9);
		scaleObject('stagelight_right', 1.1, 1.1);
		setPropertyLuaSprite('stagelight_right', 'flipX', true); --mirror sprite horizontally

		makeLuaSprite('stagecurtains', 'blank', -500, -300);
		setLuaSpriteScrollFactor('blank', 1.3, 1.3);
		scaleObject('blank', 0.9, 0.9);
	end

	setProperty('bg.antialiasing', false); 
	addLuaSprite('bg', false);
	setProperty('fire.antialiasing', false); 
	addLuaSprite('fire', false);
	setProperty('floor.antialiasing', false); 
	addLuaSprite('floor', false);
	setProperty('bg2.antialiasing', false); 
	addLuaSprite('bg2', false);


	--For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end