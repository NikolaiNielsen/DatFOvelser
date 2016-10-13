function gui_1
% simple gui setup med figur der definerer rammen for statisk og dynamisk tekst
% og push knap til at skrive den dynamiske tekst.
%
% ?bner et vindue
f=figure('Visible','off','Color','white',...
    'Position',[0,0,400,200]);
    %  f        :  addresse reference til figuren
    %  Visible  :  on/off   synlighed p? sk?rmen
    %  Color    :  baggrunds farve
    %  Position :  [nedre venstre x pos, nedre venstre y pos,
    %               nx pixels, ny pixels]

% s?tter navn p? figure frame
set(f,'Name','Simple GUI med trykknap');

% Centrerer "figure" framen midt p? computer sk?rmen
movegui(f,'center');

% ?bner et felt der indeholder statisk tekst
hstext=uicontrol('Style','text',...
    'Position', [80, 70, 140, 15],...
    'String','Skriv din tekst her:',...
    'ForegroundColor','blue',...
    'BackgroundColor','white');
    % Style            : kan have forskellige typer som bestemmer udsenet
        % 'text'       statisk tekst
        % 'edit'       dynamisk tekst der kan ?nders
        % 'pushbutton' tryk knap til aktivering
    % Position         : som for figure, men inden for figure rammen
    % String           : Tekst som skal skrives
    % ForegroundsColor : tekst farve
    % BackgroundsColor : baggrunds farve
    % Callback         : giver funktion som kaldes n?r den aktiveres

% ?bner et felt der kan skrives i
hdtext=uicontrol('Style','edit',...
    'Position', [230, 70, 140, 15]);

% ?bner et felt med en trykknap. N?r der trykkes p? den kaldes en funktion
% der lave noget relevant ift trykket
hbuttom=uicontrol('Style','pushbutton',...
    'Position', [0, 150, 100, 25],...
    'Callback',@callbackfkt,...
    'String', 'Tryk p? mig!!');

% G?r figur inholdet synlig
set(f,'Visible','on');


function callbackfkt(hObjekt, eventdata)
%
% funktion der benyttes af unicontrol ovenfor
% bem at den er indlegnet s? visse data er f?lles
% mellem de to rutiner
%
% hObjekt og eventdata indeholder info om hvilken knap der er "trykket p?"

set([hdtext, hstext, hbuttom], 'Visible', 'off');
% g?r de to tekster og knappen usynlige

prstr=get(hdtext,'String');
% Henter den skreven tekst for hdtext omr?det

% nyt felt hvor teksten fra det dynamiske felt skrives statisk
ntext=uicontrol('Style','text',...
    'Position', [100, 20, 300, 25],...
    'String',prstr,...
    'BackgroundColor','white', ...
    'ForegroundColor','red',...
    'FontSize',20);
   % BackgroundColor : baggrunds farve af feltet
   % ForegroundColor : tekst farve
   % FontSize        : font size

set(ntext,'Visible','on');
% G?r det nye felt synligt

end

end
