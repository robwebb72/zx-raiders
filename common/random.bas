FUNCTION Random(lower AS UBYTE, higher AS BYTE) AS UBYTE
    RETURN INT ( RND *(higher-lower+1))+lower: ' random range from x->y inclusive of x and y
END FUNCTION
