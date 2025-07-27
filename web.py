import sys

def main():
    in_body = False
    in_script = False
    in_tag = False
    capture_text = False
    capture_href = False
    quote_opened = False
    href_text = ''
    
    print("\033c\033[43;30m\n\n", end="")  # Limpa o ecrã e muda cor (como no C)

    for line in sys.stdin:
        i = 0
        while i < len(line):
            char = line[i]
            next5 = line[i:i+5].lower()
            next6 = line[i:i+6].lower()
            next7 = line[i:i+7].lower()
            next8 = line[i:i+8].lower()

            # Entrar no <body>
            if not in_body and next5 == '<body':
                in_body = True
                in_script = False
                in_tag = True
                i += 5
                continue

            if in_body:
                # Detetar <script> ou </script>
                if next7 == '<script':
                    in_script = True
                    in_tag = True
                    i += 7
                    continue
                elif next8 == '</script':
                    in_script = False
                    in_tag = True
                    i += 8
                    continue

                # Detetar <p>, <br>, </p> → nova linha
                elif next2 := line[i:i+2].lower() in ['<p', '</p']:
                    print()
                    i += 2
                    continue
                elif next3 := line[i:i+3].lower() in ['<br', '</']:
                    print()
                    i += 3
                    continue

                # Início e fim de tag
                if char == '<':
                    in_tag = True
                    capture_text = False
                    capture_href = False
                    href_text = ''
                elif char == '>':
                    in_tag = False
                    capture_text = True
                    if capture_href:
                        print(href_text + '"', end="")
                        capture_href = False
                    href_text = ''

                # Extrair href
                if not in_script and not capture_href and line[i:i+4].lower() == 'href':
                    j = i + 4
                    while j < len(line) and line[j] != '"':
                        j += 1
                    if j < len(line) and line[j] == '"':
                        capture_href = True
                        quote_opened = True
                        print('"', end="")
                        i = j  # vai para aspas
                        i += 1
                        continue

                if capture_href:
                    if char == '"':
                        capture_href = False
                        quote_opened = False
                        print('"', end="")
                    else:
                        if char!= '>':
                            print(char, end="")
                    i += 1
                    continue

                # Mostrar texto fora de <script> e fora de tags
                if not in_tag and not in_script and capture_text:
                    if char.isspace():
                        if i == 0 or not line[i-1].isspace():
                            print(" ", end="")
                    else:
                        if char!= '>':
                            print(char, end="")

            i += 1

if __name__ == "__main__":
    main()

