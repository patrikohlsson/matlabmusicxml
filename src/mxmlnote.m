classdef mxmlnote
    %UNTITLED7 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(Dependent)
        pitch;
        velocity;
        duration;
    end
    
    properties
        notations;
        voice;
        lyric;
    end
    
    properties(SetAccess=private, Hidden)
        ppitch;
        pvelocity;
        pduration;
        starts;
        ends;
        positioninbar;
    end
    
    methods
        function obj = mxmlnote(pitch, velocity, duration, varargin)
            obj.pitch = pitch;
            obj.velocity = velocity;
            obj.duration = duration;
            
            obj = boundfix(obj);
            
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
        
        function val = get.pitch(obj)
            val = obj.ppitch;
        end
        
        function val = get.velocity(obj)
            val = obj.pvelocity;
        end
        
        function val = get.duration(obj)
            val = obj.pduration;
        end
        
        function obj = set.pitch(obj,x)
            if(length(x)<length(obj.ppitch))
                obj.ppitch = x;
                obj.pduration = obj.pduration(1:length(x));
                obj.pvelocity = obj.pvelocity(1:length(x));
            else
                obj.ppitch = x;
                obj = boundfix(obj);
            end
        end
        
        function obj = set.velocity(obj,x)
            if(length(x)<length(obj.pvelocity))
                obj.pvelocity = x;
                obj.ppitch = obj.ppitch(1:length(x));
                obj.pduration = obj.pduration(1:length(x));
            else
                obj.pvelocity = x;
                obj = boundfix(obj);
            end
        end
        
        function obj = set.duration(obj,x)
            if(length(x)<length(obj.pduration))
                obj.pduration = x;
                obj.ppitch = obj.ppitch(1:length(x));
                obj.pvelocity = obj.pvelocity(1:length(x));
            else
                obj.pduration = x;
                obj = boundfix(obj);
            end
        end
        
    end
    
    methods(Access=private)
        function obj = boundfix(obj)
            % make sure length(ppitch) == length(velocity) ==
            % length(duration)

            if(length(obj.ppitch) == length(obj.pvelocity) ...
                == length(obj.pduration))
                return;
            end
            
            m = max([length(obj.ppitch), length(obj.pvelocity), ...
                length(obj.pduration)]);
            
            obj.ppitch    = repeatfor(obj.ppitch, m);
            obj.pvelocity = repeatfor(obj.pvelocity, m);
            obj.pduration = repeatfor(obj.pduration, m);
        end 
    end
end