### Installation and Usage

Install with `bundle install`
Run with `bundle exec ruby run.rb`

`dictionary.txt` is included in `./data`. Output files are not.

### Follow-up Questions
Were this a real feature that needed to be written for a product,
I would have the following questions for whomever wrote the spec:

- Does case matter for sequences? The spec mentions sequences of 
  unique _letters_ but lists A-z as an example implying case as a
  unique constraint. The current implementation does not normalize case.

  Normalizing case would reduce the final output of sequences by ~16%

- If normalizing case, does the resulting output need to preserve the
  original case?

### TODO
If I feel like really adding the polish I'd do the following:

- run.rb performs important things like loading the file into an array,
  this could get moved somewhere and tested a bit.

- file output mechanism could get DRY'd and tested.

- Could set it up to take any arbitrary file instead of a single designated
  file..

- .. but then I'd probably want to include something like thor to handle
  user interaction and clean up the UI..

- .. and now we're running into feature creep