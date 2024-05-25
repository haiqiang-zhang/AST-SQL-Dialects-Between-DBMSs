SELECT * FROM 
    names LEFT OUTER JOIN orig
    ON names.data = orig.data AND names.code = orig.code;
CREATE INDEX udx_orig_code_data ON orig(code, data);
SELECT * FROM 
    names LEFT OUTER JOIN orig
    ON names.data = orig.data AND names.code = orig.code;
