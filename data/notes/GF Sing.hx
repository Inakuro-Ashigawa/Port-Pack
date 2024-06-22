function onNoteHit(event)
    {
        if (event.noteType != "GF Sing") 
            return;
    
        event.character = gf;
    }
    
    function onNoteMiss(event)
    {
        if (event.noteType != "GF Sing") 
            return;
    
        event.animCancelled = true;
    }