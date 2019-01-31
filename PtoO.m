function spelling = PtoO(prep)
% Tests the network with a orthographic output
%   Gives the spelling of the output
%   Assumes the network has already been trained and the weights are
%   global.
%   orep can be either part of a table (say, words(790,2)) or a string of
%   IPHOD glyphs

    global W

    act=fPhon(prep);
    disp(size(act))
    disp(size(W))
    O=act*W;
    O=logistic(O);
    spelling=freadO(O);
    
   
end

