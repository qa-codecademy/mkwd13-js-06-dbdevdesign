const errorStatusMap = {
  "Not found": 400,
  "Unauthorized to update": 403,
  "Unauthorized to delete": 403,
};

export const handleError = (res, error) => {
  const status = errorStatusMap[error.message];
  res.status(status).json({ error: error.message });
};
