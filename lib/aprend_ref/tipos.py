from typing import TypeVar, Hashable

# Definição para o Estado e Ação.
# A restrição 'bound=Hashable' serve para permitir o uso
# destes objetos como chaves no dicionário da MemoriaEsparsa.
Estado = TypeVar('Estado', bound=Hashable)
Accao = TypeVar('Accao', bound=Hashable)