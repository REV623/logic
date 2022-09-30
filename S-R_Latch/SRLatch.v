module sr_latch(
    q,qn,r,s
);

input r,s;

output q,qn;

nor nor1(q,r,qn);
nor nor2(qn,q,s);

endmodule