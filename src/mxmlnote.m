classdef mxmlnote
    %UNTITLED7 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(Dependent)
        pitch;
        velocity;
        duration;
        starts;
        ends;
        barpos;
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
        pstarts;
        pends;
        pbarpos;
    end
    
    methods
        function obj = mxmlnote(pitch, velocity, duration, varargin)
            obj.pitch = pitch;
            obj.velocity = velocity;
            obj.duration = duration;
            
            obj = boundfix(obj);
            obj = create_starts_and_ends(obj);
            
            switch(length(varargin))
                case 1
                    if(isempty(varargin{1}))
                        obj.notations = mxmlnotations;
                    else
                        obj.notations = varargin{1};
                    end
                    obj.voice = ones(1, length(obj.pitch));
                case 2
                    if(isempty(varargin{1}))
                        obj.notations = mxmlnotations;
                    else
                        obj.notations = varargin{1};
                    end
                    obj.voice = varargin{2};
                case 3
                    if(isempty(varargin{1}))
                        obj.notations = mxmlnotations;
                    else
                        obj.notations = varargin{1};
                    end
                    obj.voice = varargin{2};
                    obj.lyric = varargin{3};
                otherwise
                    if(length(varargin)>3)
                        error('Argument error: %s', 'Wrong argument count');
                    end
                    obj.notations = mxmlnotations;
                    obj.voice = ones(1, length(obj.pitch));
            end
        end
        
        % Getters
        function val = get.pitch(obj)
            val = obj.ppitch;
        end
        
        function val = get.velocity(obj)
            val = obj.pvelocity;
        end
        
        function val = get.duration(obj)
            val = obj.pduration;
        end
        
        function val = get.starts(obj)
            val = obj.pstarts;
        end
        
        function val = get.ends(obj)
            val = obj.pends;
        end
        
        function val = get.barpos(obj)
            val = obj.pbarpos;
        end
        
        % Setters
        function obj = set.pitch(obj,x)
            if(length(x)<length(obj.ppitch))
                obj.ppitch = x;
                obj.pduration = obj.pduration(1:length(x));
                obj.pvelocity = obj.pvelocity(1:length(x));
            else
                obj.ppitch = x;
                obj = boundfix(obj);
            end
            obj = create_starts_and_ends(obj);
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
            obj = create_starts_and_ends(obj);
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
            obj = create_starts_and_ends(obj);
        end
        
        function obj = set.starts(obj, x)
            obj.pstarts = x;
            obj.pduration = obj.pends-obj.pstarts;
        end
        
        function obj = set.ends(obj, x)
            obj.pends = x;
            obj.pduration = obj.pends-obj.pstarts;
        end
        
        function obj = set.barpos(obj, x)
            obj.pbarpos = x;
        end
        
        % Operator overloading
        function a = plus(a,b)
            if(isa(b, 'mxmlnote'))
                a.pitch = a.pitch + b.pitch;
            elseif(isnumeric(b))
                a.pitch = a.pitch + b;
            end
        end
        
        function a = minus(a,b)
            if(isa(b, 'mxmlnote'))
                a.pitch = a.pitch - b.pitch;
            elseif(isnumeric(b))
                a.pitch = a.pitch - b;
            end
        end
        
        function a = mtimes(a,b)
            if(isa(b, 'mxmlnote'))
                a.pitch = a.pitch .* b.pitch;
            elseif(isnumeric(b))
                a.pitch = a.pitch .* b;
            end
        end
        
        function a = times(a,b)
            if(isa(b, 'mxmlnote'))
                a.pitch = a.pitch * b.pitch;
            elseif(isnumeric(b))
                a.pitch = a.pitch * b;
            end
        end
        
        function a = divide(a,b)
            if(isa(b, 'mxmlnote'))
                a.pitch = a.pitch / b.pitch;
            elseif(isnumeric(b))
                a.pitch = a.pitch / b;
            end
        end
        
        function a = mdivide(a,b)
            if(isa(b, 'mxmlnote'))
                a.pitch = a.pitch ./ b.pitch;
            elseif(isnumeric(b))
                a.pitch = a.pitch ./ b;
            end
        end
        
        function a = power(a,b)
            if(isa(b, 'mxmlnote'))
                a.pitch = a.pitch ^ b.pitch;
            elseif(isnumeric(b))
                a.pitch = a.pitch ^ b;
            end
        end
        
        function a = mpower(a,b)
            if(isa(b, 'mxmlnote'))
                a.pitch = a.pitch .^ b.pitch;
            elseif(isnumeric(b))
                a.pitch = a.pitch .^ b;
            end
        end
        
        function a = subsref(a, s)
            for j=1:length(s)
                if(strcmpi(s(j).type,'()'))
                    notations = a.notations;
                    voice = a.voice;
                    lyrics = a.lyric;

                    if(max(s(j).subs{1})<length(notations))
                        notations = notations(s(j).subs{1});
                    end

                    if(max(s(j).subs{1})<length(voice))
                        voice = voice(s(j).subs{1});
                    end

                    if(max(s(j).subs{1})<length(lyrics))
                        lyrics = lyrics(s(j).subs{1});
                    end

                    a = mxmlnote(a.pitch(s(j).subs{1}), a.velocity(s(j).subs{1}), ...
                        a.duration(s(j).subs{1}), notations, voice, lyrics);
                else
                    a = builtin('subsref', a, s(j));
                end
            end
        end
% TODO: FIX SUBASSIGNMENTS
%         function a = subsasgn(a, s, b)
%             for j=1:length(s)
%                 if(strcmpi(s(j).type, '()'))
%                     p = a.pitch;
%                     v = a.velocity;
%                     d = a.duration;
%                     n = a.notations;
%                     v = a.voice;
%                     l = a.lyric;
%                     
%                     p(s(j).subs{1}) = b.pitch;
%                     v(s(j).subs{1}) = b.velocity;
%                     d(s(j).subs{1}) = b.duration;
%                     n(s(j).subs{1}) = b.notations;
%                     v(s(j).subs{1}) = b.voice;
%                     l(s(j).subs{1}) = b.lyric;
%                     
%                     a = mxmlnote(p,v,d,n,v,l);
%                 else
%                     a = builtin('subsasgn', a, s(j), b);
%                 end
%             end
%         end
        
        % Shortcuts
        function obj = sp(obj,x)
            obj.pitch = x;
        end
        
        function obj = pp(obj,x)
            obj.pitch = obj.pitch + x;
        end
        
        function obj = mp(obj,x)
            obj.pitch = obj.pitch - x;
        end
        
        function obj = tp(obj,x)
            obj.pitch = obj.pitch * x;
        end
        
        function obj = dp(obj,x)
            obj.pitch = obj.pitch * x;
        end
        
        function obj = sv(obj,x)
            obj.velocity = x;
        end
        
        function obj = pv(obj,x)
            obj.velocity = obj.velocity + x;
        end
        
        function obj = mv(obj,x)
            obj.velocity = obj.velocity - x;
        end
        
        function obj = tv(obj,x)
            obj.velocity = obj.velocity * x;
        end
        
        function obj = dv(obj,x)
            obj.velocity = obj.velocity * x;
        end
        
        function obj = sd(obj,x)
            obj.duration = x;
        end
        
        function obj = pd(obj,x)
            obj.duration = obj.duration + x;
        end
        
        function obj = md(obj,x)
            obj.duration = obj.duration - x;
        end
        
        function obj = td(obj,x)
            obj.duration = obj.duration * x;
        end
        
        function obj = dd(obj,x)
            obj.duration = obj.duration * x;
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
        
        function obj = create_starts_and_ends(obj)
            obj.pstarts = fix_starts(obj.pduration);
            obj.pends = cumsum(obj.pduration);
            function dur = fix_starts(dur)
                d = dur;
                k=1;
                y = [];
                c={};
                for q=1:length(d)
                    y = [y d(q)];
                    if(q+1<=length(d) && d(q+1)~=0)
                        c{k} = y;
                        y=[];
                        k=k+1;
                    end
                end
                if(~isempty(y))
                    c{k}= y;
                end
                d = [];
                for k=1:length(c)
                    c{k}=wrev(c{k});
                    d = [d c{k}];
                end

                dur=[0 cumsum(d(1:end-1))];
            end
        end
    end
end