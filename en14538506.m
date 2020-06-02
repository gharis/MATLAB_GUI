function varargout = en14538506(varargin)
% EN14538506 MATLAB code for en14538506.fig
%      EN14538506, by itself, creates a new EN14538506 or raises the existing
%      singleton*.
%
%      H = EN14538506 returns the handle to a new EN14538506 or the handle to
%      the existing singleton*.
%
%      EN14538506('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EN14538506.M with the given input arguments.
%
%      EN14538506('Property','Value',...) creates a new EN14538506 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before en14538506_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to en14538506_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to about (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help en14538506

% Last Modified by GUIDE v2.5 14-Sep-2015 12:01:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @en14538506_OpeningFcn, ...
                   'gui_OutputFcn',  @en14538506_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before en14538506 is made visible.
function en14538506_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to en14538506 (see VARARGIN)

% Choose default command line output for en14538506
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes en14538506 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = en14538506_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in grayscale.
function grayscale_Callback(hObject, eventdata, handles)
% hObject    handle to grayscale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%gray scale image
global im imfinal
    imgray=im;
    grayimage=rgb2gray(imgray);
    axes(handles.axes2);
    imshow(grayimage);
    imfinal = grayimage;

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%load the image
%global im im1 im2
%[path,user_cance] =imgetfile();
%if user_cance
 %   msgbox(sprintf('Error'),'Error','Error'); %if cancel no image then error popups
%    return
%end
%[filename pathname]= uigetfile({'*.jpg'},'File Selector');
%im =strcat(pathname, filename);
%im =imread(path);       %read from given path
%im =im2double(im);      %in double type
%im1=im;                 % another copy of loaded image

%axes(handles,axes1)
%imshow(im)

global im im2 text pathim imfinal impath;
    [impath, user_canceled] = imgetfile;
    if user_canceled
        msgbox(sprintf('Cancelled by user!\nOperation could not be completed'),'error','error');
        return;
    end
    im = imread(impath);
    im2=im;
    axes(handles.axes1);
    imshow(im);
    axes(handles.axes2);
    imshow(im);

    set(handles.text3,'String',impath)
    imfinal = im2;

% --- Executes on button press in contours.
function contours_Callback(hObject, eventdata, handles)
% hObject    handle to contours (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im2  cnt  imfinal gim2 
    %imblck = im2bw(im2,0.6);
    %im5 = imcomplement(imblck);
    %im6 = imfill(im5,'holes');
    gim2=rgb2gray(im2);
    cnt = imcontour(gim2,5);
    axes(handles.axes2);
    imshow(cnt);

    imfinal = cnt ;

% --- Executes on button press in InvertColours.
function InvertColours_Callback(hObject, eventdata, handles)
% hObject    handle to InvertColours (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im3 im2 imfinal

    im3 = imcomplement(im2); 
    %computes the complement of the image IM.
    %IM can be a binary, grayscale, or RGB image. 
    %IM2 has the same class and size as IM.
    imshow(im3);
    imfinal =im3;


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global imfinal fullpath

    [FileName, PathName] = uiputfile('*.png', 'Save As');
    if PathName==0;
    return; 
    end
    x = fullfile(PathName,FileName);  %# <--- reverse the order of arguments
    w = waitbar(0,'Saving...');
    p_steps = 11;
    for p_step = 1:p_steps
        imwrite(imfinal, x, 'png'  );
        %computations take place here
        waitbar(p_step / p_steps)
    end
    close(w)
%imwrite(imfinal, x, 'png'  );
%imsave(imfinal);
%[FileName, PathName] = uiputfile('*.bmp', 'Save As'); %# <-- dot
%Name = fullfile(PathName,FileName);  %# <--- reverse the order of arguments
%imwrite(img, Name, 'bmp');
%[impath, user_canceled] = imputfile;
%if user_canceled
%msgbox(sprintf('Cancelled by user!\nOperation could not be completed'),'error','error');
%return;
%end
%imwrite(impath);
%filename = imfinal;
%[filename, ext, user_canceled] = imputfile;
%[filename, user_canceled] =  imsave(imfinal);
%[filename, user_canceled] = imsave(imfinal);
%[FileName, PathName] = uiputfile({'*.bmp;*.jpg;*.tif;*.png;*.gif'}, 'Save As');
% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% back to original image
global im imfinal
    reset = im;
    axes(handles.axes2);
    imshow(reset);
    imfinal = reset;

% --- Executes on button press in BW.
function BW_Callback(hObject, eventdata, handles)
% hObject    handle to BW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%black and white image
global im imfinal
    prompt={'Threshold'};
    name = 'Enter Threshold';
    defaultans = {'0.3'};
    %options.Interpreter = 'tex';
    answer = inputdlg(prompt,name,1,defaultans);
    answer_t = str2double(answer);
    imblack = im2bw(im , answer_t);
    %imblack = 1-im;
    axes(handles.axes2);
    imshow(imblack);
    imfinal = imblack;



% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global brt st_val add imfinal
    brt = handles.brt; %returns position of slider
    st_val= get(hObject,'Value');%from slider
    add =imadd(brt,st_val);
    axes(handles.axes2);
    imshow(add);
    imfinal = add;

% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in rotate_right.
function rotate_right_Callback(hObject, eventdata, handles)
% hObject    handle to rotate_right (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im im4 imfinal
    w = waitbar(0,'Proccesing...');
    p_steps = 50;
    for p_step = 1:p_steps
        im4 = imrotate(im,-90);
        %computations take place here
        waitbar(p_step / p_steps)
    end
    close(w)
    axes(handles.axes2);
    imshow(im4);
    imfinal = im4;



% --- Executes on button press in rotate_left.
function rotate_left_Callback(hObject, eventdata, handles)
% hObject    handle to rotate_left (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im im5 imfinal
    w = waitbar(0,'Proccesing...');
    p_steps = 50;
    for p_step = 1:p_steps
        im5 = imrotate(im,90);
        %computations take place here
        waitbar(p_step / p_steps)
    end
    close(w)

    axes(handles.axes2);
    imshow(im5);
    imfinal = im5;

% --- Executes on button press in Grayslice.
function Grayslice_Callback(hObject, eventdata, handles)
% hObject    handle to Grayslice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im2 grys imfinal
    prompt={'Intensity'};
    name = 'Enter Intensity';
    defaultans = {'100'};
    answer = inputdlg(prompt,name,1,defaultans);
    answer_dub = str2double(answer);
    gr=rgb2gray(im2);
    grys = grayslice(gr,answer_dub); 
    %X = grayslice(I, v) thresholds the intensity image I using the values of v, 
    %where v is a vector of values between 0 and 1,
    %returning an indexed image in X. 
    %can view the thresholded 
    axes(handles.axes2);
    imshow(grys);
    imfinal = grys;


% --- Executes on button press in gtoindex.
function gtoindex_Callback(hObject, eventdata, handles)
% hObject    handle to gtoindex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im2 imfinal
    grayimage2=rgb2gray(im2);
    prompt={'Map'};
    name = 'Enter Colormap';
    defaultans = {'64'};
    answer = inputdlg(prompt,name,1,defaultans);
    answer_dub = str2double(answer);
    [X, map] = gray2ind(grayimage2, answer_dub);
    %converts the grayscale image I to an indexed image X.
    %n specifies the size of the colormap, gray(n). 
    %n must be an integer between 1 and 65536.
    %If n is omitted, it defaults to 64.
    axes(handles.axes2);
    imshow(X, map);
    imfinal = X;


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im2 
    J = imnoise(im2,'salt & pepper',0.02);
    J = imnoise(I,'salt & pepper',0.02);


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3

global im2 J imfinal
contents = get(hObject,'Value')
switch contents
    case 1
        axes(handles.axes2);
        imshow(im2);
        j=im2;
    case 2
        J = imnoise(im2,'gaussian'); 
        %white noise with constant mean and variance
         axes(handles.axes2);
        imshow(J);

    case 3
        J = imnoise(im2,'poisson');
        %Poisson noise
        axes(handles.axes2);
        imshow(J);    
    case 4
        J = imnoise(im2,'salt & pepper');
        %On and off pixels
        axes(handles.axes2);
        imshow(J);      
    case 5
        J = imnoise(im2,'speckle');
        %Multiplicative noise
        axes(handles.axes2);
        imshow(J);
    otherwise
end
imfinal = J;

% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over text4.
function text4_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to text4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Brightness.
function Brightness_Callback(hObject, eventdata, handles)
% hObject    handle to Brightness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im2 brt
    brt = im2;
    axes(handles.axes2);
    imshow(brt);
    handles.brt =brt;
    % Update handles structure
    guidata(hObject, handles);


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over text5.
function text5_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to text5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in crop.
function crop_Callback(hObject, eventdata, handles)
% hObject    handle to crop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im2 imfinal crp
    crp =imcrop(im2);
    axes(handles.axes2);
    imshow(crp);
    imfinal = crp;


                 



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double
global im2 stri imfinal impath

cmd_sting= get(handles.edit3,'String');

%eval(cmd_sting); 
%if this enable then switch case not works since varable updated


switch cmd_sting
    case  'load'
        pushbutton6_Callback(hObject, eventdata, handles);
    case  'save'
        save_Callback(hObject, eventdata, handles);
    case 'reset' 
        reset_Callback(hObject, eventdata, handles);
    case 'gray scale'  
        grayscale_Callback(hObject, eventdata, handles);
    case 'g to index'
        gtoindex_Callback(hObject, eventdata, handles);
    case 'black & white' 
        BW_Callback(hObject, eventdata, handles);
    case 'invert'
        InvertColours_Callback(hObject, eventdata, handles);
    case'rotate l'
        rotate_left_Callback(hObject, eventdata, handles);
    case'rotate r' 
        rotate_right_Callback(hObject, eventdata, handles);
    case'rotate' 
        rotate_v_Callback(hObject, eventdata, handles);
    case 'gray slice' 
        Grayslice_Callback(hObject, eventdata, handles); 
    case 'crop'     
        crop_Callback(hObject, eventdata, handles)
    otherwise
end
%switch cmd_sting
    %if cmd_sting % x
        %pushbutton6_Callback(hObject, eventdata, handles);
        %clearvars x;
    %elseif cmd_sting % y
        %pushbutton10_Callback(hObject, eventdata, handles);
    %end    
%if cmd_sting % x
%        pushbutton6_Callback(hObject, eventdata, handles);
%if cmd_sting % y
 %       pushbutton10_Callback(hObject, eventdata, handles);
        
        
%end
    

%if expression
  %  statements
%elseif expression
  %  statements
%else
  %  statements
%end
    %stri = get(hObject,'Value')
    %switch contents
    %    case 1
    %user_input =get(hObject,'String');
    %user_input=char(user_input);
    %load=char(Laod);
    %user_input =char(user_input);
    %if user_input == load
    %    pushbutton6_Callback(hObject, eventdata, handles);
    %end
    %switch eventdata.Key
       %     case 'return'
       %        handles.img=eval(get(handles.edit3,'String'));
               %imshow(handles.img,'Parent',handles.axes2);
        %       axes(handles.axes2);
        %       imshow(handles.img);
    %end
    %x=double('load');
    %y=double('save');
    %z=double('reset');

function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Resize.
function Resize_Callback(hObject, eventdata, handles)
% hObject    handle to Resize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Resize contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Resize
global im2 imre imfinal
contents = get(hObject,'Value')
switch contents
    case 1
        axes(handles.axes2);
        imshow(im2);
    case 2
        imre = imresize(im2,[20 20]); 
         axes(handles.axes2);
        imshow(imre);

    case 3
        imre = imresize(im2,[128 160]);
        axes(handles.axes2);
        imshow(imre);    
    case 4
        imre = imresize(im2,[320 480]);
        axes(handles.axes2);
        imshow(imre);      
    case 5
        imre = imresize(im2,[640 480]);
        axes(handles.axes2);
        imshow(imre);

    case 6
        imre = imresize(im2,[720 1280]);
        axes(handles.axes2);
        imshow(imre);
    case 7
        imre = imresize(im2,[1080 1920]);
        axes(handles.axes2);
        imshow(imre)
    case 8
        prompt={'x-axis'};
        name = 'Horizontal';
        defaultans = {'0'};
        answer_xa = str2double(inputdlg(prompt,name,1,defaultans));
        prompt={'y-axis'};
        name = 'Vertical';
        defaultans = {'0'};
        answer_ya = str2double(inputdlg(prompt,name,1,defaultans));
        imre = imresize(im2,[answer_xa answer_ya]);
        axes(handles.axes2);
        imshow(imre)
    
    otherwise
end
imfinal = imre;

% --- Executes during object creation, after setting all properties.
function Resize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Resize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in about.
function about_Callback(hObject, eventdata, handles)
% hObject    handle to about (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Hints: get(hObject,'String') returns contents of edit3 as text
%str2double(get(hObject,'String')) returns contents of edit3 as a double

    msgbox('Designed by P.A.G. Harischandra ','IMAGE ANALYZER');

        %Multiplicative noise
 %user_input = get(handles.edit3,'String');
%user_input = char(user_input);

%switch user_input
%if(handles.a_is_set ==1)
        %pushbutton6_Callback(hObject, eventdata, handles);
%end
   
        %prompt={'type command'};
        %name = 'command';
        %defaultans = {'command line'};
        %answer_cm = inputdlg(prompt,name,1,defaultans);
        %answer_cm;
        %axes(handles.axes2);
        %imshow(filt);

% --- Executes on selection change in Filter.
function Filter_Callback(hObject, eventdata, handles)
% hObject    handle to Filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Filter contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Filter
global im2 filt imfinal h
contents = get(hObject,'Value')
switch contents
    case 1
        axes(handles.axes2);
        imshow(im2);
    case 2
        
        %Create a filter, h, that can be used to approximate linear camera motion.     
        prompt={'Motion'};
        name = 'Linear Motion';
        defaultans = {'40'};
       
        answer_m = str2double(inputdlg(prompt,name,1,defaultans));
        prompt={'Angle'};
        name = 'ClockwiseAngle';
        defaultans = {'50'};
        
        answer_t = str2double(inputdlg(prompt,name,1,defaultans));
        %answer_dub = str2double(answer);
        %temp = inputdlg(prompt,dlg_title);
        %{l,t} = answer_dub;  %{'20','hsv'};
        %l=answer_dub(0);
        %t=answer_dub(1);
       % [l, t ]= answer_dub;
        h = fspecial('motion', answer_m, answer_t);
        %the linear motion of a camera by len pixels, 
        %with an angle of theta degrees in a counterclockwise direction.
        %Approximates the linear motion of a camera
        %Apply the filter, using imfilter, 
        %to the image originalRGB to create a new image, filteredRGB.
        filt = imfilter(im2, h);
        axes(handles.axes2);
        imshow(filt);

    case 3
       %im2 =im2double(im2);
       % im2g = gpuArray(im2);
       % Iblur = imgaussfilt(im2g, 2);
      
        
        prompt={'Radius'};
        name = 'Disck Radius';
        defaultans = {'5'};
        
        answer_r = str2double(inputdlg(prompt,name,1,defaultans));
        %answer_dub = str2double(answer);
        h = fspecial('disk', answer_r);%Circular averaging filter (pillbox)
        filt = imfilter(im2,h,'replicate');
        %'replicate'input array value outside the bounds of the array are assumed to equal the nearest array border value
        axes(handles.axes2);
        imshow(filt); 
        %returns a circular averaging filter (pillbox) within the square matrix of size 2*radius+1. 
        %The default radius is 5.
    case 4
        prompt={'Alpha (0.1-1.0)'};
        name = 'Parameter';
        defaultans = {'0.2'};
        
        answer_a = str2double(inputdlg(prompt,name,1,defaultans));
        h = fspecial('laplacian', answer_a);
        filt = imfilter(im2,h,'replicate');%The parameter alpha controls the shape of the Laplacian 
        %returns a 3-by-3 filter approximating the shape of the two-dimensional Laplacian operator. 
        %The parameter alpha must be in the range 0.0 to 1.0. 
        %The default value for alpha is 0.2.
        axes(handles.axes2);
        imshow(filt);      
    case 5
        prompt={'Sigma (>0)'};
        name = 'Standard Deviation';
        defaultans = {'0.5'};
        
        answer_s = str2double(inputdlg(prompt,name,1,defaultans));

        h = fspecial('log', answer_s);%Laplacian of Gaussian filter
        %returns a rotationally symmetric Laplacian of Gaussian filter of size hsize with standard deviation sigma (positive).
        %hsize can be a vector specifying the number of rows and columns in h, or it can be a scalar, in which case h is a square matrix. 
        %The default value for hsize is [5 5] and 0.5 for sigma.
        filt = imfilter(im2,h,'replicate');
        axes(handles.axes2);
        imshow(filt);

    case 6
        h = fspecial('sobel');%Sobel horizontal edge-emphasizing filter
        filt = imfilter(im2,h,'replicate');
        %returns a 3-by-3 filter h (shown below) that emphasizes horizontal edges using the smoothing effect by approximating a vertical gradient.
        %If you need to emphasize vertical edges, transpose the filter h'.
        axes(handles.axes2);
        imshow(filt);

    otherwise
end
imfinal = filt;





% --- Executes during object creation, after setting all properties.
function Filter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Arithmetic.
function Arithmetic_Callback(hObject, eventdata, handles)
% hObject    handle to Arithmetic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Arithmetic contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Arithmetic


% --- Executes during object creation, after setting all properties.
function Arithmetic_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Arithmetic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu7.
function popupmenu7_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu7
global im2  imfinal roi grayimage3 position ro co B_mask im2_c im2_r   binry
contents = get(hObject,'Value')
switch contents
    case 1
        axes(handles.axes2);
        imshow(im2);
   % case 2
        %grayimage3=rgb2gray(im2);
        %[X, map] = gray2ind(grayimage3, 1);
        %roi = roicolor(X,1000,1000); 
        %roif = roifilt2(roi);
        %returns an ROI selected as those pixels that lie within the colormap range [low high].
        %axes(handles.axes2);
        %imshow(roif,map)

   % case 3
      
    case 2
        %pos = getPosition(im2)
        %id = addNewPositionCallback(im2,fcn(pos));
        
        %hROI = imfreehand(id); 

        %position = getPosition(hROI);
%h = imfreehand( gca ); setColor(h,'red');
%position = wait( h );
%BW = createMask( h );
        %BW = createMask(hid); %returns a mask, or binary image, 
        %that is the same size as the input image with 1s inside the ROI object h and 0s everywhere else. 
        %The input image must be contained within the same axes as the ROI
      % d= delete(BW) 
      % color = getColor(h) 
        %roi = imfreehand(im2);
       % axes(handles.axes2);
       % imshow(BW);  
      % fcn = makeConstrainToRectFcn('imfreehand', 20, 20)
      % h = imfreehand(gca);
      % h=delete(h);
      %  axes(handles.axes2);
      % imshow(h);
    case 3
        %[ro co] = ginput(4);%  take region inside clicked 5 points 
       % im2resized =imresize(720 1280);%constant size 'for loop about'
        %[im2_r im2_c] = size(im2);
       %B_mask = roipoly(im2resized,ro,co);%BinaryMask
        %for cl = 1:720
        %    for rw = 1:1280
         %       if B_mask(ro,co)==im2resized(cl,rw)
         %           roi(cl,rw) =im2(cl,rw)
          [x, y, BW, xi, yi] = roipoly(im2)  
          J = roifill(BW,xi,yi)
        %binry =im2double(im2);
        %grayim = rgb2gray(im2);
       % roi = roipoly(grayim);
        %roi = roipoly(roi ,r, c);
        %roifill = regionfill(grayim,roi);
        %roifill = regionfill(binry,roi);
        axes(handles.axes2);
        imshow(J);

   
    otherwise
end
imfinal = roi;


% --- Executes during object creation, after setting all properties.
function popupmenu7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in rotate_v.
function rotate_v_Callback(hObject, eventdata, handles)
% hObject    handle to rotate_v (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im2 imfinal p_steps
    prompt={'-360 to +360'};
    name = 'Angle';
    defaultans = {'0'};
    answer_an = str2double(inputdlg(prompt,name,1,defaultans));


    w = waitbar(0,'Proccesing...');
    p_steps = 50;
    for p_step = 1:p_steps
        im_r_v = imrotate(im2,answer_an);
        %computations take place here
        waitbar(p_step / p_steps)
    end
    close(w) 
    axes(handles.axes2);
    imshow(im_r_v);
    imfinal = im_r_v;



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double
global im2 imfinal x_val y_val
x_val=str2double(get(hObject,'String'));
        imre1 = imresize(im2,[x_val y_val]); 
        axes(handles.axes2);
        imshow(imre1);
        imfinal = imre1 ;
        
% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double
global im2 imfinal x_val y_val
%x_val=str2double(get(hObject.edit4,'String'));
y_val = str2double(get(hObject,'String'));
        imre1 = imresize(im2,[x_val y_val]); 
        axes(handles.axes2);
        imshow(imre1);
        
        imfinal =imre1;
% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Arithmatic.
function Arithmatic_Callback(hObject, eventdata, handles)
global impath1 impath2 imfinal K
[impath1, user_canceled1] = imgetfile;
%[impath2, user_canceled2] = imgetfile;
contents = get(hObject,'Value');
switch contents
case 1
       %im2 =im2double(im2);
       % im2g = gpuArray(im2);
       % Iblur = imgaussfilt(im2g, 2);
      
        I = imread(impath1);      
        axes(handles.axes3);
        imshow(I);  
        prompt={'Add'};
        name = 'Contant';
        defaultans = {'0'};
        contant = str2double(inputdlg(prompt,name,1,defaultans));

        K = imadd(I,contant);
        axes(handles.axes5);
        imshow(K);
        %J = imread(impath2);
        

        %axes(handles.axes4);
        %imshow(J);
 
        %K = imadd(I,J,'uint8');
        %prompt={'Radius'};
        %name = 'Disck Radius';
        %defaultans = {'5'};
        
        %answer_r = str2double(inputdlg(prompt,name,1,defaultans));
        %answer_dub = str2double(answer);
       % h = fspecial('disk', answer_r);%Circular averaging filter (pillbox)
        %filt = imfilter(im2,h,'replicate');
 
case 2
         
        I = imread(impath1);      
        axes(handles.axes3);
        imshow(I);  
        prompt={'Subtract'};
        name = 'Contant';
        defaultans = {'0'};
        contant = str2double(inputdlg(prompt,name,1,defaultans));

        K = imsubtract(I,contant);
        axes(handles.axes5);
        imshow(K); 
case 3
         
        I = imread(impath1);      
        axes(handles.axes3);
        imshow(I);  
        prompt={'Multiply'};
        name = 'Scaler';
        defaultans = {'0'};
        Scaler = str2double(inputdlg(prompt,name,1,defaultans));

        K = immultiply(I,Scaler);
        axes(handles.axes5);
        imshow(K);
case 4
         
        I = imread(impath1);      
        axes(handles.axes3);
        imshow(I);  
        prompt={'Divide'};
        name = 'Scaler';
        defaultans = {'0'};
        Scaler = str2double(inputdlg(prompt,name,1,defaultans));

        K = imdivide(I,Scaler);
        axes(handles.axes5);
        imshow(K);

        
        
        
    
        otherwise
end
imfinal=K;
% hObject    handle to Arithmatic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Arithmatic contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Arithmatic


% --- Executes during object creation, after setting all properties.
function Arithmatic_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Arithmatic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
