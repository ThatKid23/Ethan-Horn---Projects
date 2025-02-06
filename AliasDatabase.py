import pandas as pd

# Load your spreadsheet with the university data
file_path = 'Acct Name Alias .xlsx'  # Update with the path to your file
df = pd.read_excel(file_path, sheet_name='Acct Name Alias ')

# Function to generate aliases
def create_alias(account_name):
    # Abbreviate 'University' as 'Univ.' and try to reduce other parts for brevity
    account_name = account_name.replace("University", "Univ.")
    account_name = account_name.replace("College", "Coll.")
    
    # Adding state abbreviations if present, such as "Virginia" to "VA"
    state_abbreviations = {
        "Virginia": "VA", "California": "CA", "Texas": "TX", "Florida": "FL", "New York": "NY",
        "Michigan": "MI", "Ohio": "OH", "Pennsylvania": "PA", "Illinois": "IL", "North Carolina": "NC",
        "Georgia": "GA", "Washington": "WA", "Arizona": "AZ", "Tennessee": "TN", "Indiana": "IN",
        "Missouri": "MO", "Maryland": "MD", "Wisconsin": "WI", "Colorado": "CO", "Minnesota": "MN",
        "South Carolina": "SC", "Alabama": "AL", "Louisiana": "LA", "Kentucky": "KY", "Oregon": "OR",
        "Oklahoma": "OK", "Connecticut": "CT", "Iowa": "IA", "Utah": "UT", "Arkansas": "AR",
        "Nevada": "NV", "Kansas": "KS", "New Jersey": "NJ", "Mississippi": "MS", "New Mexico": "NM",
        "Nebraska": "NE", "West Virginia": "WV", "Idaho": "ID", "Hawaii": "HI", "Maine": "ME",
        "Montana": "MT", "Rhode Island": "RI", "Delaware": "DE", "South Dakota": "SD", "North Dakota": "ND",
        "Alaska": "AK", "Vermont": "VT", "Wyoming": "WY", "District of Columbia": "DC"
    }
    
    # Replace state names with abbreviations
    for state, abbrev in state_abbreviations.items():
        account_name = account_name.replace(state, abbrev)
    
    # Ensure alias is no longer than 30 characters
    if len(account_name) > 30:
        account_name = account_name[:30]
    
    return account_name

# Process all 5000 entries (or however many rows your dataset has)
df['Generated Alias'] = df['Account Name'].apply(create_alias)

# Save the updated dataframe to a new Excel file
output_path = 'updated_acct_aliases_5000_entries.xlsx'  # Specify the output file path
df.to_excel(output_path, index=False)

print(f"Aliases generated and saved to {output_path}")
