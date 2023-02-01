%%Initialize
%% MyoMex Quickstart
% Before you begin, please read through README.txt and follow all steps
% for setting up the Myo Connect application, Myo SDK, and building the
% MEX function |myo_mex|.
%
% Mark Tomaszewski, mark@mark-toma.com, marktoma@buffalo.edu

%% Before Using |MyoMex|
% If you decided not to read through |README.txt|, let's at least show you
% the quickest possible way to get started.
clear all; close all; clc;
install_myo_mex; % adds directories to MATLAB search path
% install_myo_mex save % additionally saves the path

sdk_path = 'C:\myo-sdk-win-0.9.0'; % root path to Myo SDK
build_myo_mex(sdk_path); % builds myo_mex

%% MyoMex Usage
% Before using |MyoMex|, you must decide how many Myos would like to use in
% this session. The MyoMex constructor argument |countMyos| specifies this
% value. Make sure that exactly |countMyos| devices are connected in the
% Myo Connect application or else MyoMex construction will fail. The Myo
% device(s) should also be worn on a human arm to avoid unexpected
% disconnection of the device from Myo Connect. If Myo Connect loses a
% device at any time, MyoMex will terminate and invalidate itself.

countMyos = 1;

%% Instantiate MyoMex
% After constructing a new |MyoMex| instance, we'll inspect its properties.

mm = MyoMex(countMyos)

%%
% Notice that the only property of |mm| is a |1xcountMyos| MyoData object.
% There is no device data stored by |mm|. The data from each physical Myo
% device is passed through |mm| to each element of |mm.myoData|.

%% Inspect |MyoData|
% Since |MyoData| objects inherit from |handle|, we can get handles to the
% |MyoData| objects representing each physical device and use them
% directly.

m1 = mm.myoData(1);
if countMyos == 2, m2 = mm.myoData(2); end
m1.stopStreaming();

