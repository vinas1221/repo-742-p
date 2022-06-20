# Backdating Git commits script
$startDate = Get-Date -Year 2022 -Month 06 -Day 20  # Starting from January 1, 2017
$endDate = Get-Date  # Today's date
$commitCount = ($endDate - $startDate).Days + 1  # Total number of days between start and end dates

# Realistic file names
$fileNames = @(
    "report.md", "notes.txt", "summary.docx", "index.html",
    "config.json", "readme.md", "data.csv", "project_plan.docx",
    "script.ps1", "analysis.py", "log.txt", "requirements.txt"
)

# Commit messages
$messages = @(
    "Updated project documentation",
    "Fixed bug in data processing script",
    "Added initial project plan",
    "Refactored code for better readability",
    "Enhanced UI responsiveness",
    "Updated README with new features",
    "Improved error handling logic",
    "Optimized database queries",
    "Added validation for user input",
    "Fixed typos in documentation"
)

# Generate daily commits
for ($i = 0; $i -lt $commitCount; $i++) {
    # Calculate the commit date (incrementing daily from start date)
    $commitDate = $startDate.AddDays($i).ToString("yyyy-MM-ddTHH:mm:ss")

    # Pick a random file name and message
    $fileName = $fileNames | Get-Random
    $commitMessage = $messages | Get-Random

    # Ensure the file exists or create it
    if (!(Test-Path -Path $fileName)) {
        Set-Content -Path $fileName -Value "Initial content for $fileName"
    }

    # Make a small change to the file
    Add-Content -Path $fileName -Value "Temporary commit content for $commitDate"

    # Add and commit the file with a backdated timestamp
    git add $fileName
    git commit -m "$commitMessage" --date="$commitDate"
}

Write-Host "Generated $commitCount backdated commits successfully!"
