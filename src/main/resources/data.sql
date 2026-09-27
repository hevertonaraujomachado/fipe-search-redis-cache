INSERT INTO marcas (nome) VALUES
                              ('Toyota'),
                              ('Honda');

INSERT INTO modelos (marca_id, nome) VALUES
                                         (1, 'Corolla'),
                                         (1, 'Hilux'),
                                         (2, 'Civic'),
                                         (2, 'HR-V'),
                                         (2, 'Fit');

INSERT INTO referencias (modelo_id, ano_modelo, preco, mes_referencia) VALUES
                                                                           (1, 2023, 118095.00, '2026-03'),
                                                                           (2, 2021, 208322.00, '2026-03'),
                                                                           (3, 2021, 128455.00, '2026-03'),
                                                                           (4, 2021, 115856.00, '2026-03'),
                                                                           (5, 2021,  84776.00, '2026-03');