---
-- A clean, simple implementation of the A* pathfinding algorithm for Lua.
--
-- This implementation has no dependencies and has a simple interface. It
-- takes a table of nodes, a start and end point and a "valid neighbor"
-- function which makes it easy to adapt the module's behavior, especially
-- in circumstances where valid paths would frequently change.
--
-- @module astar

local astar = {}

local function dist_between ( nodeA, nodeB )

	return astar.distance ( nodeA.x, nodeA.y, nodeB.x, nodeB.y )
end

local function heuristic_cost_estimate ( nodeA, nodeB )

	return astar.distance ( nodeA.x, nodeA.y, nodeB.x, nodeB.y )
end

local function is_valid_node ( node, neighbor )

	return true
end

local function lowest_f_score ( set, f_score )

	local lowest, bestNode = math.huge, nil
	for _, node in ipairs ( set ) do
		local score = f_score [ node ]
		if score < lowest then
			lowest, bestNode = score, node
		end
	end
	return bestNode
end

local function neighbor_nodes ( theNode, nodes, valid_node )

	local neighbors = {}
	for _, node in ipairs ( nodes ) do
		if theNode ~= node and valid_node ( theNode, node ) then
			table.insert ( neighbors, node )
		end
	end
	return neighbors
end

local function not_in ( set, theNode )

	for _, node in ipairs ( set ) do
		if node == theNode then return false end
	end
	return true
end

local function remove_node ( set, theNode )

	for i, node in ipairs ( set ) do
		if node == theNode then
			set [ i ] = set [ #set ]
			set [ #set ] = nil
			break
		end
	end
end

local function unwind_path ( flat_path, map, current_node )

	if map [ current_node ] then
		table.insert ( flat_path, 1, map [ current_node ] )
		return unwind_path ( flat_path, map, map [ current_node ] )
	else
		return flat_path
	end
end

---
-- Calculate the distance between two 2D points.
--
-- @tparam number x1 First point's coordinate in the X axis.
-- @tparam number y1 First point's coordinate in the Y axis.
-- @tparam number x2 Second point's coordinate in the X axis.
-- @tparam number y2 Second point's coordinate in the Y axis.
-- @treturn The distance between the points.
function astar.distance ( x1, y1, x2, y2 )
	return math.sqrt ( ( (x2-x1)^2 ) + ( (y2-y1)^2 ) )
end

---
-- Calculate a path between two nodes.
--
-- @tparam table start Start node.
-- @tparam table goal Goal node.
-- @tparam table nodes Array of nodes.
-- @tparam ?function valid_node Function called with two arguments: the
--  "current" node and the candidate node, and should return a boolean
--  indicating if we can "move" to that node.
-- @treturn A lua table of ordered nodes from start to end.
function astar.path ( start, goal, nodes, valid_node )

	local closedset = {}
	local openset = { start }
	local came_from = {}

	valid_node = valid_node or is_valid_node

	local g_score, f_score = {}, {}
	g_score [ start ] = 0
	f_score [ start ] = g_score [ start ] + heuristic_cost_estimate ( start, goal )

	while #openset > 0 do

		local current = lowest_f_score ( openset, f_score )
		if current == goal then
			local path = unwind_path ( {}, came_from, goal )
			table.insert ( path, goal )
			return path
		end

		remove_node ( openset, current )
		table.insert ( closedset, current )

		local neighbors = neighbor_nodes ( current, nodes, valid_node )
		for _, neighbor in ipairs ( neighbors ) do
			if not_in ( closedset, neighbor ) then

				local tentative_g_score = g_score [ current ] + dist_between ( current, neighbor )

				if not_in ( openset, neighbor ) or tentative_g_score < g_score [ neighbor ] then
					came_from 	[ neighbor ] = current
					g_score 	[ neighbor ] = tentative_g_score
					f_score 	[ neighbor ] = g_score [ neighbor ] + heuristic_cost_estimate ( neighbor, goal )
					if not_in ( openset, neighbor ) then
						table.insert ( openset, neighbor )
					end
				end
			end
		end
	end
	return nil -- no valid path
end

return astar
