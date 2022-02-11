function out = seguimiento(file, x, y)
    vid = VideoReader(file);
    ref = read(vid,1);
    Mblock = ref(y:y+15, x:x+15, :);
    out = [];

    while hasFrame(vid)
        f = readFrame(vid);
        [vx, vy, errMin] = exhaustiva(Mblock, f, x, y, 500);
        out = [ out ; x + vx, y+vy];
    end
end