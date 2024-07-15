package templates

import (
	"bytes"
	"log"
	"os"
	"text/template"
)

// Render executes the workflow template with the provided parameters and returns the rendered output.
func Render(p RenderParams) (string, error) {

	// Check if the template file exists at ./templates/workflow.yaml, falling back to ./workflow.yaml if not found.
	tmplPath := "./templates/workflow.yaml"
	if _, err := os.Stat(tmplPath); err != nil && os.IsNotExist(err) {
		tmplPath = "./workflow.yaml"
	}

	// Parse the template file into a *template.Template object. Panic if parsing fails.
	tmpl := template.Must(template.ParseFiles(tmplPath))
	workflowT, err := tmpl.ParseFiles(tmplPath)
	if err != nil {
		log.Panicf("failed to parse workflow template: %s", err)
	}

	// Create a new buffer to hold the rendered template output.
	buf := bytes.NewBuffer(nil)

	// Execute the template with the provided RenderParams, writing the result to the buffer.
	// Panic if template execution fails.
	if err := workflowT.Execute(buf, p); err != nil {
		log.Panicf("failed to execute workflow template: %s", err)
	}

	// Return the rendered template output as a string.
	return buf.String(), nil
}

// RenderParams contains the data used to populate the workflow template.
type RenderParams struct {
	// Name is the name of the workflow.
	Name    string
	// Login is the GitHub user or organization that owns the repository.
	Login   string
	// Date is the date the workflow is being generated.
	Date    string
	// RunsOn specifies the environment the workflow should run on.
	RunsOn  string
	// Secrets contains any secrets that need to be passed to the workflow.
	Secrets map[string]string
}
