function[out]=meandata(data, window, stride)

[r,c]=size(data);
l=length([1:stride:length(data)-window+1]);
out=zeros(l,c);

count=1;
for i=1:stride:length(data)-window+1
   out(count,:)=mean(data(i:i+window-1,:));
   count=count+1;
end


