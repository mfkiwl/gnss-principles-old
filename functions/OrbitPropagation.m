
function M = OrbitPropagation(M, T, Mdot, Omegadot)

    M_next = M + T*(Mdot - Omegadot);

    M = M_next;
end