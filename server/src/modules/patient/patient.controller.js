const patientService = require('./patient.service');

async function createPatient(req, res, next) {
  try {
    const patient = await patientService.createPatient(req.body);
    res.status(201).json({
      success: true,
      message: 'Patient created successfully',
      data: patient,
    });
  } catch (error) {
    next(error);
  }
}

async function getPatient(req, res, next) {
  try {
    const { id } = req.params;
    const includeInactive = req.query.includeInactive === 'true';
    const patient = await patientService.getPatient(id, { includeInactive });
    res.status(200).json({
      success: true,
      message: 'Patient retrieved successfully',
      data: patient,
    });
  } catch (error) {
    next(error);
  }
}

async function updatePatient(req, res, next) {
  try {
    const { id } = req.params;
    const patient = await patientService.updatePatient(id, req.body);
    res.status(200).json({
      success: true,
      message: 'Patient updated successfully',
      data: patient,
    });
  } catch (error) {
    next(error);
  }
}

async function deletePatient(req, res, next) {
  try {
    const { id } = req.params;
    const patient = await patientService.deletePatient(id);
    res.status(200).json({
      success: true,
      message: 'Patient deleted successfully',
      data: patient,
    });
  } catch (error) {
    next(error);
  }
}

async function listPatients(req, res, next) {
  try {
    const pageNumber = Number(req.query.page) || 1;
    const limitNumber = Number(req.query.limit) || 10;
    const includeInactive = req.query.includeInactive === 'true';
    const result = await patientService.listPatients({
      page: pageNumber,
      limit: limitNumber,
      includeInactive,
    });
    res.status(200).json({
      success: true,
      message: 'Patients retrieved successfully',
      data: result,
    });
  } catch (error) {
    next(error);
  }
}

async function searchPatients(req, res, next) {
  try {
    const pageNumber = Number(req.query.page) || 1;
    const limitNumber = Number(req.query.limit) || 10;
    const includeInactive = req.query.includeInactive === 'true';
    const result = await patientService.searchPatients({
      searchTerm: req.query.search,
      page: pageNumber,
      limit: limitNumber,
      includeInactive,
    });
    res.status(200).json({
      success: true,
      message: 'Patient search results retrieved successfully',
      data: result,
    });
  } catch (error) {
    next(error);
  }
}

module.exports = {
  createPatient,
  getPatient,
  updatePatient,
  deletePatient,
  listPatients,
  searchPatients,
};