function Hk = functionHk(d,K,N,nbrOfMonteCarloRealizations)
% Generates Rayleigh-determined ray traced channel model for use with
% multi-user downlink beamforming
% returns a K-by-N-by-nbrMonteCarlo complex double
% 1. Set coordinates of users as a random space, assuming array is on
% 0-axis
    UserBound = 10; % meters
    UserCoords = UserBound*rand(2,K) - repmat([5;0],1,K); % zero-center the x portion
    %d = 0.05; % meters, should be a function of lambda
    fc = 5e3; %hz
    propSpeed = 343;
    lambda = propSpeed/fc;
    BW = 500; %Hz
    ArrayCoords = zeros(2,N);
    for n=1:N
        ArrayCoords(1,n) = (n-1)*d;
    end
    ArrayCoords = ArrayCoords - mean(ArrayCoords(1,:));
    ReflectLine = repmat([-5,2.5],N,1).';
    NumPaths = K*N*2; % with num reflects
    pathDist = zeros(K,N,2);
    p = 1;
    for k=1:K
        %don't add users together
        for n=1:N
            pathDist(k,n,1) = sqrt((UserCoords(1,k)-ArrayCoords(1,n))^2 ...
                + (UserCoords(2,k)-ArrayCoords(2,n))^2);
            pathDist(k,n,2) = sqrt((UserCoords(1,k)-ReflectLine(1,n))^2 ...
                + (UserCoords(2,k)-ReflectLine(2,n))^2) + ...
                sqrt((ArrayCoords(1,n)-ReflectLine(1,n))^2 ...
                + (ArrayCoords(2,n)-ReflectLine(2,n))^2);
        end
    end
    PathGain = (4*pi*pathDist/lambda).^2;
    PathDelay = pathDist/propSpeed;
    %Subc = linspace(-BW,BW,1) + fc;
    Hk = zeros(K,N,nbrOfMonteCarloRealizations);
    Hk(:,:,1) = sum(PathGain.*exp(-1i*2*pi*fc.*PathDelay),3);
    Hk(:,:,2) = Hk(:,:,1);
    Hk = Hk/max(mean(Hk(:,:,1),1));
    %Hk = (randn(K,N,nbrOfMonteCarloRealizations)+1i*randn(K,N,nbrOfMonteCarloRealizations))/sqrt(2);
end