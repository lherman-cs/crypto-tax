from typing import Iterator

TURBOTAX_HEADERS = [
    "Date",
    "Type",
    "Sent Asset",
    "Sent Amount",
    "Received Asset",
    "Received Amount",
    "Fee Asset",
    "Fee Amount",
    "Market Value Currency",
    "Market Value",
    "Description",
    "Transaction Hash",
    "Transaction ID",
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
        "Date",
        "Source",
        "Wallet/Exchange",
        "Wallet/Exchange (User Defined Name)",
        "Type",
        "Received Amount",
        "Received Currency",
        "Received Wallet",
        "Received Address",
        "Received Tag",
        "Sent Amount",
        "Sent Currency",
        "Sent Wallet",
        "Sent Address",
        "Sent Tag",
        "Fee Amount",
        "Fee Currency",
        "ST Capital Gain/Loss",
        "ST Capital Gain/Loss",
        "Comment"
    ]
    if is_header:
        aliases = {
            "Sent Currency": "Sent Asset",
            "Received Currency": "Received Currency",
            "Fee Currency": "Fee Currency",
            "Comment": "Description",
        }
        return aliases.get(value, value)

    header = headers[col_index]
    if header == "Type":
        type_map = {
            "Receive": "Staking",
            "Buy": "Buy",
            "Sell": "Sale",
            "Trade": "Convert",
            "Cost": "Expense",
            "Transfer": "Transfer",
            # TODO: Convert "Send" to either "Withdrawal" or "Deposit"
        }
    return value


def transform_csv(file_path: str, transform_fn):
    is_header = True
    mapper = []
    for row in read_csv(file_path):
        if is_header:
            row = list(row)
            mapper = generate_mapper(row, transform_fn)
            is_header = False

        transformed_cols = [''] * len(TURBOTAX_HEADERS)
        for i, col in enumerate(row):
            mapped_index = mapper[i]
            if mapped_index == -1:
                continue

            # transform_fn on header has been used
            transformed_cols[mapped_index] = transform_fn(i, col, False)
        yield transformed_cols


for cols in transform_csv('cryptocom.csv', cryptocom_transformer):
    print(cols)
