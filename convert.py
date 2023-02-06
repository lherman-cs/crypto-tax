from typing import Iterator

TURBOTAX_HEADERS = [
        "Currency Name",
        "Purchase Date",
        "Cost Basis",
        "Date Sold",
        "Proceeds"
]

def read_line(line: str):
    has_quote = False
    buf = []
    for char in line:
        if char in [',', '\n'] and not has_quote:
            # end of value
            value = ''.join(buf)
            buf = []
            yield value
            continue

        if char == '"':
            has_quote = not has_quote

        buf.append(char)
            

def read_csv(file: str):
    with open(file, 'r') as csv:
        for line in csv:
            yield read_line(line)


def generate_mapper(headers: Iterator[str], transform_fn):
    mapper = [-1] * len(headers) # -1 means drop
    for i, header in enumerate(headers):
        header = transform_fn(i, header, True)

        for j, target_header in enumerate(TURBOTAX_HEADERS):
            if target_header in header:
                mapper[i] = j
                break

    return mapper


def cryptocom_transformer(col_index: int, value: str, is_header: bool) -> str:
    headers = [
            "Asset Amount",
            "Asset Name",
            "Date of Sale",
            "Date of Acquisition",
            "Net Proceeds (USD)",
            "Cost Basis (USD)",
            "ST Capital Gain/Loss (USD)",
            "LT Capital Gain/Loss (USD)"
    ]
    if is_header:
        if "Asset Name" in value:
            return "Currency Name"
        elif "Date of Acquisition" in value:
            return "Purchase Date"
        elif "Cost Basis (USD)" in value:
            return "Cost Basis"
        elif "Date of Sale" in value:
            return "Date Sold"
        elif "Net Proceeds (USD)" in value:
            return "Proceeds"
        else:
            return value

    # if headers[col_index] in ["Cost Basis (USD)", "Net Proceeds (USD)"]:
    #     parsed = value.replace('"', '')
    #     parsed = ''.join(parsed.split(','))
    #     parsed = float(parsed)
    #     value = f'{parsed:.2f}'

    return value


def transform_csv(file_path: str, transform_fn):
    is_header = True
    mapper = []
    for row in read_csv(file_path):
        transformed_cols = [''] * len(TURBOTAX_HEADERS)
        if is_header:
            row = list(row)
            mapper = generate_mapper(row, transform_fn)
            transformed_cols = TURBOTAX_HEADERS.copy()

        for i, col in enumerate(row):
            mapped_index = mapper[i]
            if mapped_index == -1:
                continue

            # transform_fn on header has been used
            transformed_cols[mapped_index] = transform_fn(i, col, is_header)

        if is_header:
            is_header = False
        yield transformed_cols


with open('out.csv', 'w') as out:
    for cols in transform_csv('cryptocom.csv', cryptocom_transformer):
        print(','.join(cols), file=out, flush=True)


