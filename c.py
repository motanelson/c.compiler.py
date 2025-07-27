import os
import re

class Subrotina:
    def __init__(self, nome):
        self.nome = nome
        self.codigo = []
        self.variaveis = []

    def adicionar_instrucao(self, instrucao):
        self.codigo.append(instrucao)

    def adicionar_variavel(self, linha):
        linha = linha.strip().rstrip(";")
        if linha.startswith("int "):
            partes = linha[4:].split("=")
            if len(partes) == 2:
                nome = partes[0].strip()
                valor = partes[1].strip()
                self.variaveis.append(f"{nome}_{self.nome}: dw {valor}")
            else:
                nome = partes[0].strip()
                self.variaveis.append(f"{nome}_{self.nome}: dw 0")
        elif linha.startswith("char*") or linha.startswith("char *"):
            partes = linha.split("=")
            if len(partes) == 2:
                nome = partes[0].replace("char*", "").replace("char *", "").strip()
                texto = partes[1].strip().strip('"')
                self.variaveis.append(f"{nome}_{self.nome}: db '{texto}', 0")
        else:
            self.codigo.append("; variável não reconhecida: " + linha)

    def gerar_codigo(self):
        resultado = [f"{self.nome}:"]
        resultado += [f"    {linha}" for linha in self.codigo]
        resultado.append("    ret\n")
        return "\n".join(resultado)

    def gerar_variaveis(self):
        return "\n".join(self.variaveis)


class CompiladorCparaAsm:
    def __init__(self):
        self.subrotinas = {}
        self.calls_indefinidos = set()

    def compilar(self, ficheiro_entrada):
        if not ficheiro_entrada.endswith(".c"):
            print("O ficheiro deve ter extensão .c")
            return

        try:
            with open(ficheiro_entrada, "r") as f:
                codigo = f.read()
        except FileNotFoundError:
            print("Ficheiro não encontrado.")
            return

        nome_saida = ficheiro_entrada.replace(".c", ".S")
        self.processar_codigo(codigo)
        self.gravar_saida(nome_saida)

    def processar_codigo(self, codigo):
        funcoes = re.findall(r"void\s+(\w+)\s*\(\s*\)\s*{([^}]*)}", codigo, re.DOTALL)

        for nome, corpo in funcoes:
            sub = Subrotina(nome)
            linhas = corpo.strip().splitlines()
            for linha in linhas:
                linha = linha.strip()
                if linha.endswith(";"):
                    linha = linha[:-1]

                if linha.startswith("call "):
                    destino = linha.split("call")[1].strip()
                    sub.adicionar_instrucao(f"call {destino}")
                    if destino not in self.subrotinas:
                        self.calls_indefinidos.add(destino)
                elif linha.startswith("int ") or "char*" in linha or "char *" in linha:
                    sub.adicionar_variavel(linha + ";")
                else:
                    sub.adicionar_instrucao(self.converter_instrucao(linha))

            self.subrotinas[nome] = sub

    def converter_instrucao(self, linha):
        return "; instrução desconhecida ou ignora: " + linha

    def gravar_saida(self, nome_saida):
        with open(nome_saida, "w") as f:
            f.write("; Código Assembly 16-bit (NASM syntax)\n\n")

            f.write("section .text\n")
            for nome in self.subrotinas:
                f.write(self.subrotinas[nome].gerar_codigo())
                f.write("\n")

            f.write("section .data\n")
            for nome in self.subrotinas:
                variaveis = self.subrotinas[nome].gerar_variaveis()
                if variaveis:
                    f.write(variaveis + "\n")

            for indef in self.calls_indefinidos:
                if indef not in self.subrotinas:
                    f.write(f"{indef}:\n")
                    f.write("    ; chamada indefinida\n")
                    f.write("    ret\n\n")

        print(f"Compilação concluída. Ficheiro gerado: {nome_saida}")


if __name__ == "__main__":
    print("\033c\033[43;30m\n")
    ficheiro = input("Nome do ficheiro C (.c): ").strip()
    compilador = CompiladorCparaAsm()
    compilador.compilar(ficheiro)
