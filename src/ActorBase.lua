local class = require("object")
base_c = class (
    "base_c",
    {
        -- Position
        xPos = nil,
        yPos = nil,
        -- Bounding box
        width = nil,
        height = nil,
        right = nil,
        left = nil,
        top = nil,
        bottom = nil,
        -- Animate stuff
        playingAnimation = nil,
        animations = {}
        
    }
)

function base_c:init(width, height)
    self.width, self.height = width, height
    self.top, self.bottom = width
    self.left, self.right = height
end

function base_c:changeBoundingBoxSizes(width, height)
    self.width, self.height = width, height
    self.top, self.bottom = width
    self.left, self.right = height
end

-- Collision detection function between 2 base_c, not line specific (that's a lot simpler)
function base_c:CheckCollision(other)
    return self.xPos < other.xPos+other.width and
            other.xPos < self.xPos+self.width and
            self.yPos < other.yPos+other.height and
            other.yPos < self.yPos+self.height
end

-- Animations area

function base_c:newAnimation(image, width, height, duration) -- create new animation, shove it in self's animations table
    local animation = {}
    animation.spriteSheet = image;
    animation.quads = {};

    for y = 0, image:getHeight() - height, height do
        for x = 0, image:getWidth() - width, width do
            table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
        end
    end

    return animation
end