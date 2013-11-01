classdef mxmlnote
    %UNTITLED7 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(SetAccess=public)
        pitch;
        velocity;
        duration;
        notations;
        voice;
        lyric;
    end
    
    properties(SetAccess=private, Hidden)
        starts;
        ends;
        positioninbar;
    end
    
    methods
        function obj = mxmlnote(pitch, velocity, duration, varargin)
            obj.pitch = pitch;
            obj.velocity = velocity;
            obj.duration = duration;
            switch(length(varargin))
                case 1
                    obj.notations = varargin{1};
                case 2
                    obj.notations = varargin{1};
                    obj.voice = varargin{2};
                case 3
                    obj.notations = varargin{1};
                    obj.voice = varargin{2};
                    obj.lyric = varargin{3};
                otherwise
                    if(length(varargin)>3)
                        error('Argument error: %s', 'Wrong argument count');
                    end
            end
        end
    end
    
    methods(Access=private)
        function obj = boundfix(obj)
            % make sure length(pitch) == length(velocity) ==
            % length(duration)
        end 
    end
end

