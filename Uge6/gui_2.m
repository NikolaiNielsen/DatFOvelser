function gui_2
% simple gui med figur ramme, statisk og dynamisk tekst,
% slider og grafik.
%
% ??bner et vindue
f=figure('Visible','off',...
         'Color','white',...
         'Position',[0,0,400,400]);
    %  Visible  :  on/off   synlighed p?? sk??rmen
    %  Color    :  baggrunds farve
    %  Position :  [nedre venstre x pos, nedre venstre y pos,
    %               nx pixels, ny pixels]

% set navn p?? figure frame
set(f,'Name','Simple GUI eksempel');

% Placere "figure" frame midt p?? sk??rmen
movegui(f,'center');

minval=0;   % dynamisk omr??de for slideren
maxval=2*pi;
% ??bner et felt der indeholder statisk tekst
UI_SliderX=uicontrol('Style','slider',...
    'Position', [70, 330, 100, 25],...
    'String','x-value',...
    'BackgroundColor','blue',...
    'Min',minval,'Max',maxval,...
    'Callback',@callbackfkt);
    % Style kan have forskellige typer
        % 'text'       statisk tekst
        % 'edit'       dynamisk tekst der kan ??nders
        % 'pushbutton' tryk knap til aktivering
        % 'slider'     en slider til at v??lge v??rdier
    % Position         : som for figure, men inden for figure rammen
    % String           : Tekst som skal skrives
    % BackgroundsColor : baggrunds farve
    % Min, Max         : dynamisk omr??de for slideren

UI_SliderY=uicontrol('Style','slider',...
        'Position', [70, 375, 100, 25],...
        'String','y-value',...
        'BackgroundColor','blue',...
        'Min',minval,'Max',maxval,...
        'Callback',@callbackfkt);
        % Style kan have forskellige typer
            % 'text'       statisk tekst
            % 'edit'       dynamisk tekst der kan ??nders
            % 'pushbutton' tryk knap til aktivering
            % 'slider'     en slider til at v??lge v??rdier
        % Position         : som for figure, men inden for figure rammen
        % String           : Tekst som skal skrives
        % BackgroundsColor : baggrunds farve
        % Min, Max         : dynamisk omr??de for slideren

% Skriver min v??rdi i felt
UI_MinTextX=uicontrol('Style','text',...
    'Position', [20, 335, 40, 15],...
    'String',num2str(minval),...
    'BackgroundColor','white');

% Skriver max v??rdi i felt
UI_MaxTextX=uicontrol('Style','text',...
    'Position', [180, 335, 40, 15],...
    'String',num2str(maxval),...
    'BackgroundColor','white');

UI_MinTextX=uicontrol('Style','text',...
    'Position', [20, 375, 40, 15],...
    'String',num2str(minval),...
    'BackgroundColor','white');

% Skriver max v??rdi i felt
UI_MaxTextX=uicontrol('Style','text',...
    'Position', [180, 375, 40, 15],...
    'String',num2str(maxval),...
    'BackgroundColor','white');

% Felt til slider v??rdi
UI_SliderValTextX=uicontrol('Style','text',...
    'Position', [230, 330, 75, 15],...
    'Visible','off',...
    'BackgroundColor','white');

UI_SliderValTextY=uicontrol('Style','text',...
    'Position', [230, 375, 75, 15],...
    'Visible','off',...
    'BackgroundColor','white');

% skaber grafisk omr??de i vinduet
UI_Axes=axes('Units','Pixels','Position',[75,50,250,250]);
    % Units  :  hvilket enhed Pos skal regnes i
        % Pixels  grafiske pixels

% Position af div er sat i procent af figure omr??det
% istedet for i pixels.
set([UI_SliderX, UI_MinTextX, UI_MaxTextX, UI_SliderValTextX, UI_Axes], 'Units', 'Normalized');

view(3);


% G??r figuren synlig
set(f,'Visible','on');

function callbackfkt(hObjekt, eventdata)
%
% funktion der benyttes til unicontrol ovenfor
% bem at det denne gang er indlegeret i overordnet funktion s?? visse data er f??lles
% mellem de to rutiner
%
%  hObjekt, eventdata indeholder info om hvilken knap der er "trykket p??"

% Henter v??rdien efter slideren er flyttet
numX=get(UI_SliderX,'Value');
numY=get(UI_SliderY,'Value');
% G??r det nye felt synligt med den nye slider v??rdi
set(UI_SliderValTextX,'Visible','on','String',sprintf('x = %f',num2str(numX)));
set(UI_SliderValTextY,'Visible','on','String',sprintf('y = %f',num2str(numY)));
% plotter sin(x) for omr??det 0-slider v??rdien
%x=0:num/50:num;
%y=sin(x);
[x,y] = meshgrid(-numX:numX/50:numX,-numY:numY/50:numY);
z = sin(x).*sin(y);
surf(x,y,z)
shading flat
colormap jet
axis([-maxval,maxval,-maxval,maxval,-1,1]);
xlabel('x');
ylabel('y');
zlabel('sin(x)*sin(y)');


end

end
