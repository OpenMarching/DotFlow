width = 48.75
fieldType = "HighSchool"

function Full()
	addSkyEnvironment(Vector3(-45, -30, 0))
	drawGroundPlane(0, (width / 2) * -1, 120, width, "DARKGREEN")
	drawSubPlane(1000, 1000, "BLACK")

	-- addMesh("G:\\OpenMarchingAssets\\Stadium.glb",Vector3(0, 0, width / -2), Vector3(0, 0, 0), 1)
	addText("OPEN MARCHING", Vector3(-55, 0.01, width / -2), Vector3(-90, 0, 90), 30, "WHITE")
	addText("OPEN MARCHING", Vector3(55, 0.01, width / -2), Vector3(-90, 0, 270), 30, "WHITE")
	addImage("res://textures/DotFlowLogo512.png", Vector3(0, 0.005, width / -2), Vector3(-90, 0, 0), 2.0)

	drawLine(Vector2(5, -5), Vector2(0, -10), 0.5, "WHITE")

	for i = -50, 50 do
		if i % 5 ~= 0 then
			drawPlane(i, 0, 0.1, 0.61, "WHITE") -- High School
			drawPlane(i, (width * -1) + 0.61, 0.1, 0.61, "WHITE")
			if fieldType == "HighSchool" then
				drawPlane(i, (width / -2) - (17.7 / 2), 0.1, 0.61, "WHITE")
				drawPlane(i, (width / -2) + (17.7 / 2) + .61, 0.1, 0.61, "WHITE")
			end
			if fieldType == "College" then -- College
				drawPlane(i, (width / -2) - (13.4 / 2), 0.1, 0.61, "WHITE")
				drawPlane(i, (width / -2) + (13.4 / 2) + .61, 0.1, 0.61, "WHITE")
			end
			if fieldType == "NFL" then -- NFL
				drawPlane(i, (width / -2) - (6 / 2), 0.1, 0.61, "WHITE")
				drawPlane(i, (width / -2) + (6 / 2) + .61, 0.1, 0.61, "WHITE")
			end
		end
		if i % 5 == 0 then
			drawLine(i, 0, i, width * -1, 0.1, "WHITE")
			drawPlane(i, 0, 0.1, width, "WHITE")
			if i ~= -50 and i ~= 50 then
				if fieldType == "HighSchool" then
					drawPlane(i, (width / -2) - (17.7 / 2), 0.6, 0.1, "WHITE")
					drawPlane(i, (width / -2) + (17.7 / 2) + .1, 0.6, 0.1, "WHITE")
				end
				if fieldType == "College" then -- College
					drawPlane(i, (width / -2) - (13.4 / 2), 0.6, 0.1, "WHITE")
					drawPlane(i, (width / -2) + (13.4 / 2) + .1, 0.6, 0.1, "WHITE")
				end
				if fieldType == "NFL" then -- NFL
					drawPlane(i, (width / -2) - (6 / 2), 0.6, 0.1, "WHITE")
					drawPlane(i, (width / -2) + (6 / 2) + .1, 0.6, 0.1, "WHITE")
				end
			end
		end
		if getPlatform() == "Windows" then
			if i % 10 == 0 and i ~= -50 and i ~= 50 then
				val = i
				if i < 0 then
					val = i * -1
				end
				addText(tostring(50 - val):gsub(".", "%1 "):sub(1, -2), Vector3(i, 0.01, width * -1 + 5), Vector3(-90, 0, 180), 20,"WHITE")
				addText(tostring(50 - val):gsub(".", "%1 "):sub(1, -2), Vector3(i, 0.01, -5), Vector3(-90, 0, 0), 20, "WHITE")
			end
		else
			if i % 10 == 0 and i ~= -50 and i ~= 50 then
				addText("1 0", Vector3(40, 0.01, width * -1 + 5), Vector3(-90, 0, 180), 20, "WHITE")
				addText("1 0", Vector3(40, 0.01, -5), Vector3(-90, 0, 0), 20, "WHITE")
				addText("2 0", Vector3(30, 0.01, width * -1 + 5), Vector3(-90, 0, 180), 20, "WHITE")
				addText("2 0", Vector3(30, 0.01, -5), Vector3(-90, 0, 0), 20, "WHITE")
				addText("3 0", Vector3(20, 0.01, width * -1 + 5), Vector3(-90, 0, 180), 20, "WHITE")
				addText("3 0", Vector3(20, 0.01, -5), Vector3(-90, 0, 0), 20, "WHITE")
				addText("4 0", Vector3(10, 0.01, width * -1 + 5), Vector3(-90, 0, 180), 20, "WHITE")
				addText("4 0", Vector3(10, 0.01, -5), Vector3(-90, 0, 0), 20, "WHITE")
				addText("5 0", Vector3(0, 0.01, width * -1 + 5), Vector3(-90, 0, 180), 20, "WHITE")
				addText("5 0", Vector3(0, 0.01, -5), Vector3(-90, 0, 0), 20, "WHITE")
				addText("4 0", Vector3(-10, 0.01, width * -1 + 5), Vector3(-90, 0, 180), 20, "WHITE")
				addText("4 0", Vector3(-10, 0.01, -5), Vector3(-90, 0, 0), 20, "WHITE")
				addText("3 0", Vector3(-20, 0.01, width * -1 + 5), Vector3(-90, 0, 180), 20, "WHITE")
				addText("3 0", Vector3(-20, 0.01, -5), Vector3(-90, 0, 0), 20, "WHITE")
				addText("2 0", Vector3(-30, 0.01, width * -1 + 5), Vector3(-90, 0, 180), 20, "WHITE")
				addText("2 0", Vector3(-30, 0.01, -5), Vector3(-90, 0, 0), 20, "WHITE")
				addText("1 0", Vector3(-40, 0.01, width * -1 + 5), Vector3(-90, 0, 180), 20, "WHITE")
				addText("1 0", Vector3(-40, 0.01, -5), Vector3(-90, 0, 0), 20, "WHITE")
			end
		end
	end

	drawPlane(0, .5, 120, .5, "WHITE")
	drawPlane(0, width * -1, 120, .5, "WHITE")
	drawPlane(-60.5, .5, 1, width + 1, "WHITE")
	drawPlane(60.5, .5, 1, width + 1, "WHITE")
end

function Flat() -- Function that runs creating the flat field
	addSkyEnvironment(Vector3(-45, -30, 0))
	drawGroundPlane(0, (width / 2) * -1, 120, width, "DARKGREEN")
	drawSubPlane(1000, 1000, "BLACK")

	-- addMesh("G:\\OpenMarchingAssets\\Stadium.glb",Vector3(0, 0, width / -2), Vector3(0, 0, 0), 1)
	addText("OPEN MARCHING", Vector3(-55, 0.01, width / -2), Vector3(-90, 0, 90), 30, "WHITE")
	addText("OPEN MARCHING", Vector3(55, 0.01, width / -2), Vector3(-90, 0, 270), 30, "WHITE")
	addImage("res://textures/DotFlowLogo512.png", Vector3(0, 0.005, width / -2), Vector3(-90, 0, 0), 2.0)

	drawLine(Vector2(5, -5), Vector2(0, -10), 0.5, "WHITE")

	for i = -50, 50 do
		if i % 5 ~= 0 then
			drawPlane(i, 0, 0.1, 0.61, "WHITE") -- High School
			drawPlane(i, (width * -1) + 0.61, 0.1, 0.61, "WHITE")
			if fieldType == "HighSchool" then
				drawPlane(i, (width / -2) - (17.7 / 2), 0.1, 0.61, "WHITE")
				drawPlane(i, (width / -2) + (17.7 / 2) + .61, 0.1, 0.61, "WHITE")
			end
			if fieldType == "College" then -- College
				drawPlane(i, (width / -2) - (13.4 / 2), 0.1, 0.61, "WHITE")
				drawPlane(i, (width / -2) + (13.4 / 2) + .61, 0.1, 0.61, "WHITE")
			end
			if fieldType == "NFL" then -- NFL
				drawPlane(i, (width / -2) - (6 / 2), 0.1, 0.61, "WHITE")
				drawPlane(i, (width / -2) + (6 / 2) + .61, 0.1, 0.61, "WHITE")
			end
		end
		if i % 5 == 0 then
			drawLine(i, 0, i, width * -1, 0.1, "WHITE")
			drawPlane(i, 0, 0.1, width, "WHITE")
			if i ~= -50 and i ~= 50 then
				if fieldType == "HighSchool" then
					drawPlane(i, (width / -2) - (17.7 / 2), 0.6, 0.1, "WHITE")
					drawPlane(i, (width / -2) + (17.7 / 2) + .1, 0.6, 0.1, "WHITE")
				end
				if fieldType == "College" then -- College
					drawPlane(i, (width / -2) - (13.4 / 2), 0.6, 0.1, "WHITE")
					drawPlane(i, (width / -2) + (13.4 / 2) + .1, 0.6, 0.1, "WHITE")
				end
				if fieldType == "NFL" then -- NFL
					drawPlane(i, (width / -2) - (6 / 2), 0.6, 0.1, "WHITE")
					drawPlane(i, (width / -2) + (6 / 2) + .1, 0.6, 0.1, "WHITE")
				end
			end
		end
		if getPlatform() == "Windows" then
			if i % 10 == 0 and i ~= -50 and i ~= 50 then
				val = i
				if i < 0 then
					val = i * -1
				end
				addText(tostring(50 - val):gsub(".", "%1 "):sub(1, -2), Vector3(i, 0.01, width * -1 + 5), Vector3(-90, 0, 180), 20,"WHITE")
				addText(tostring(50 - val):gsub(".", "%1 "):sub(1, -2), Vector3(i, 0.01, -5), Vector3(-90, 0, 0), 20, "WHITE")
			end
		else
			if i % 10 == 0 and i ~= -50 and i ~= 50 then
				addText("1 0", Vector3(40, 0.01, width * -1 + 5), Vector3(-90, 0, 180), 20, "WHITE")
				addText("1 0", Vector3(40, 0.01, -5), Vector3(-90, 0, 0), 20, "WHITE")
				addText("2 0", Vector3(30, 0.01, width * -1 + 5), Vector3(-90, 0, 180), 20, "WHITE")
				addText("2 0", Vector3(30, 0.01, -5), Vector3(-90, 0, 0), 20, "WHITE")
				addText("3 0", Vector3(20, 0.01, width * -1 + 5), Vector3(-90, 0, 180), 20, "WHITE")
				addText("3 0", Vector3(20, 0.01, -5), Vector3(-90, 0, 0), 20, "WHITE")
				addText("4 0", Vector3(10, 0.01, width * -1 + 5), Vector3(-90, 0, 180), 20, "WHITE")
				addText("4 0", Vector3(10, 0.01, -5), Vector3(-90, 0, 0), 20, "WHITE")
				addText("5 0", Vector3(0, 0.01, width * -1 + 5), Vector3(-90, 0, 180), 20, "WHITE")
				addText("5 0", Vector3(0, 0.01, -5), Vector3(-90, 0, 0), 20, "WHITE")
				addText("4 0", Vector3(-10, 0.01, width * -1 + 5), Vector3(-90, 0, 180), 20, "WHITE")
				addText("4 0", Vector3(-10, 0.01, -5), Vector3(-90, 0, 0), 20, "WHITE")
				addText("3 0", Vector3(-20, 0.01, width * -1 + 5), Vector3(-90, 0, 180), 20, "WHITE")
				addText("3 0", Vector3(-20, 0.01, -5), Vector3(-90, 0, 0), 20, "WHITE")
				addText("2 0", Vector3(-30, 0.01, width * -1 + 5), Vector3(-90, 0, 180), 20, "WHITE")
				addText("2 0", Vector3(-30, 0.01, -5), Vector3(-90, 0, 0), 20, "WHITE")
				addText("1 0", Vector3(-40, 0.01, width * -1 + 5), Vector3(-90, 0, 180), 20, "WHITE")
				addText("1 0", Vector3(-40, 0.01, -5), Vector3(-90, 0, 0), 20, "WHITE")
			end
		end
	end

	drawPlane(0, .5, 120, .5, "WHITE")
	drawPlane(0, width * -1, 120, .5, "WHITE")
	drawPlane(-60.5, .5, 1, width + 1, "WHITE")
	drawPlane(60.5, .5, 1, width + 1, "WHITE")
end

function Paper()	-- Function that runs creating the paper field
	addFlatEnvironment("WHITE")
	drawGroundPlane(0, (width / 2) * -1, 120, width, "WHITE")

	addText("Show Title", Vector3(0, 0.01, (width + 6) * -1), Vector3(-90, 0, 0), 20, "BLACK")
	addText("Show Subtitle", Vector3(0, 0.01, (width + 3.5) * -1), Vector3(-90, 0, 0), 10, "BLACK")

	addText("Created With DotFlow by Open Marching", Vector3(0, 0.01, 3.5), Vector3(-90, 0, 0), 10, "BLACK")

	addText("OPEN MARCHING", Vector3(-55, 0.01, width / -2), Vector3(-90, 0, 90), 30, "BLACK")
	addText("OPEN MARCHING", Vector3(55, 0.01, width / -2), Vector3(-90, 0, 270), 30, "BLACK")

	for i = -50, 50 do
		if i % 5 ~= 0 then
			drawPlane(i, 0, 0.1, 0.61, "BLACK") -- High School
			drawPlane(i, (width * -1) + 0.61, 0.1, 0.61, "BLACK")
			if fieldType == "HighSchool" then
				drawPlane(i, (width / -2) - (17.7 / 2), 0.1, 0.61, "BLACK")
				drawPlane(i, (width / -2) + (17.7 / 2) + .61, 0.1, 0.61, "BLACK")
			end
			if fieldType == "College" then -- College
				drawPlane(i, (width / -2) - (13.4 / 2), 0.1, 0.61, "BLACK")
				drawPlane(i, (width / -2) + (13.4 / 2) + .61, 0.1, 0.61, "BLACK")
			end
			if fieldType == "NFL" then -- NFL
				drawPlane(i, (width / -2) - (6 / 2), 0.1, 0.61, "BLACK")
				drawPlane(i, (width / -2) + (6 / 2) + .61, 0.1, 0.61, "BLACK")
			end
		end
		if i % 5 == 0 then
			drawLine(i, 0, i, width * -1, 0.1, "BLACK")
			drawPlane(i, 0, 0.1, width, "BLACK")
			if i ~= -50 and i ~= 50 then
				if fieldType == "HighSchool" then
					drawPlane(i, (width / -2) - (17.7 / 2), 0.6, 0.1, "BLACK")
					drawPlane(i, (width / -2) + (17.7 / 2) + .1, 0.6, 0.1, "BLACK")
				end
				if fieldType == "College" then -- College
					drawPlane(i, (width / -2) - (13.4 / 2), 0.6, 0.1, "BLACK")
					drawPlane(i, (width / -2) + (13.4 / 2) + .1, 0.6, 0.1, "BLACK")
				end
				if fieldType == "NFL" then -- NFL
					drawPlane(i, (width / -2) - (6 / 2), 0.6, 0.1, "BLACK")
					drawPlane(i, (width / -2) + (6 / 2) + .1, 0.6, 0.1, "BLACK")
				end
			end
		end
		if getPlatform() == "Windows" then
			if i % 10 == 0 and i ~= -50 and i ~= 50 then
				val = i
				if i < 0 then
					val = i * -1
				end
				addText(tostring(50 - val):gsub(".", "%1 "):sub(1, -2), Vector3(i, 0.01, width * -1 + 5), Vector3(-90, 0, 180), 20,"BLACK")
				addText(tostring(50 - val):gsub(".", "%1 "):sub(1, -2), Vector3(i, 0.01, -5), Vector3(-90, 0, 0), 20, "BLACK")
			end
		else
			if i % 10 == 0 and i ~= -50 and i ~= 50 then
				addText("1 0", Vector3(40, 0.01, width * -1 + 5), Vector3(-90, 0, 180), 20, "BLACK")
				addText("1 0", Vector3(40, 0.01, -5), Vector3(-90, 0, 0), 20, "BLACK")
				addText("2 0", Vector3(30, 0.01, width * -1 + 5), Vector3(-90, 0, 180), 20, "BLACK")
				addText("2 0", Vector3(30, 0.01, -5), Vector3(-90, 0, 0), 20, "BLACK")
				addText("3 0", Vector3(20, 0.01, width * -1 + 5), Vector3(-90, 0, 180), 20, "BLACK")
				addText("3 0", Vector3(20, 0.01, -5), Vector3(-90, 0, 0), 20, "BLACK")
				addText("4 0", Vector3(10, 0.01, width * -1 + 5), Vector3(-90, 0, 180), 20, "BLACK")
				addText("4 0", Vector3(10, 0.01, -5), Vector3(-90, 0, 0), 20, "BLACK")
				addText("5 0", Vector3(0, 0.01, width * -1 + 5), Vector3(-90, 0, 180), 20, "BLACK")
				addText("5 0", Vector3(0, 0.01, -5), Vector3(-90, 0, 0), 20, "BLACK")
				addText("4 0", Vector3(-10, 0.01, width * -1 + 5), Vector3(-90, 0, 180), 20, "BLACK")
				addText("4 0", Vector3(-10, 0.01, -5), Vector3(-90, 0, 0), 20, "BLACK")
				addText("3 0", Vector3(-20, 0.01, width * -1 + 5), Vector3(-90, 0, 180), 20, "BLACK")
				addText("3 0", Vector3(-20, 0.01, -5), Vector3(-90, 0, 0), 20, "BLACK")
				addText("2 0", Vector3(-30, 0.01, width * -1 + 5), Vector3(-90, 0, 180), 20, "BLACK")
				addText("2 0", Vector3(-30, 0.01, -5), Vector3(-90, 0, 0), 20, "BLACK")
				addText("1 0", Vector3(-40, 0.01, width * -1 + 5), Vector3(-90, 0, 180), 20, "BLACK")
				addText("1 0", Vector3(-40, 0.01, -5), Vector3(-90, 0, 0), 20, "BLACK")
			end
		end
	end

	drawPlane(0, .5, 120, .5, "BLACK")
	drawPlane(0, width * -1, 120, .5, "BLACK")
	drawPlane(-60.5, .5, 1, width + 1, "BLACK")
	drawPlane(60.5, .5, 1, width + 1, "BLACK")
end

function Grid(gridSize)  -- Function that runs creating the grid
	stepper = 2.5

	while stepper >= width * -1 - 2.5 do
		drawGridLine(-62.5, stepper, 62.5, stepper, 0.02)
		stepper = stepper - gridSize
	end

	stepper = -62.5

	while stepper <= 62.5 do
		drawGridLine(stepper, 2.5, stepper, width * -1 - 2.5, 0.02)
		stepper = stepper + gridSize
	end
end
